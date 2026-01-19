{ pkgs ? import <nixpkgs> { } }:
let
  appWhitelist = with pkgs; [
    aircrack-ng
    bashInteractive
    coreutils-full
    curl
    dig
    findutils
    git
    gnugrep
    gnused
    hashcat
    hcxtools
    inetutils
    iw
    less
    ncurses
    nmap
    procps
    util-linux
    vim
    wget
    sudo
    which
  ];

  ci = pkgs.closureInfo { rootPaths = appWhitelist; };
  binPath = pkgs.lib.makeBinPath appWhitelist;
in
pkgs.mkShell {
  buildInputs = [ pkgs.bubblewrap ] ++ appWhitelist;

  shellHook = ''
    if [ -n "$SANDBOXED" ]; then return; fi
    export SANDBOXED=1

    # A few environment variables for terminal/bash

    ROOT="/dev/shm/$(whoami)"
    mkdir -p "$ROOT"
    chmod 0700 "$ROOT"
    trap 'rm -rf "$ROOT"' EXIT

    for d in home/$(whoami) tmp run etc usr/bin; do
      mkdir -p "$ROOT/$d"
    done
    chmod 1777 "$ROOT/tmp"
    chmod 0700 "$ROOT/home/$(whoami)"

    BWRAP=(${pkgs.bubblewrap}/bin/bwrap)
    ARGS=()
    ARGS+=(--die-with-parent --unshare-pid)

    # Build our directory structure
    ARGS+=(--bind "$ROOT" /)
    ARGS+=(--proc /proc)
    ARGS+=(--dev /dev)

    # Add applications
    while IFS= read -r p; do
      mkdir -p "$ROOT/$p"
      ARGS+=(--ro-bind "$p" "$p")
    done < ${ci}/store-paths

    # Setup networking
    if [ -f /etc/resolv.conf ]; then
      touch "$ROOT/etc/resolv.conf"
      ARGS+=(--ro-bind /etc/resolv.conf /etc/resolv.conf)
    fi
    if [ -f /etc/hosts ]; then
      touch "$ROOT/etc/hosts"
      ARGS+=(--ro-bind /etc/hosts /etc/hosts)
    fi
    if [ -f /etc/nsswitch.conf ]; then
      touch "$ROOT/etc/nsswitch.conf"
      ARGS+=(--ro-bind /etc/nsswitch.conf /etc/nsswitch.conf)
    fi
    if [ -f /etc/protocols ]; then
      touch "$ROOT/etc/protocols"
      ARGS+=(--ro-bind /etc/protocols /etc/protocols)
    fi

    ARGS+=(--share-net)

    # Ensure /usr/bin/env works for shebangs
    ARGS+=(--dir /usr)
    ARGS+=(--dir /usr/bin)
    ARGS+=(--symlink ${pkgs.coreutils}/bin/env /usr/bin/env)

    # Provide /bin/bash
    ARGS+=(--dir /bin)
    ARGS+=(--symlink ${pkgs.bashInteractive}/bin/bash /bin/bash)
    ARGS+=(--symlink ${pkgs.bashInteractive}/bin/bash /bin/sh)

    # Clean environment (appWhitelist apps only)
    ARGS+=(--setenv PATH '${binPath}:/bin:/usr/bin')
    ARGS+=(--setenv HOME /home/$(whoami))
    ARGS+=(--setenv PS1 '[sandbox:\w]\$ ')
    ARGS+=(--setenv TERM xterm-256color)
    ARGS+=(--setenv HISTFILE /dev/null)
    ARGS+=(--setenv HISTSIZE 10)
    ARGS+=(--setenv HISTFILESIZE 0)

    if [ -f "$HOME/$(whoami)/.bashrc" ]; then
      cp "$HOME/$(whoami)/.bashrc" "$ROOT/home/$(whoami)/.bashrc"
    fi

    ${pkgs.bubblewrap}/bin/bwrap "''${ARGS[@]}" --chdir /home/$(whoami) /bin/bash --noprofile --norc -i

    exit
  '';
}
