update-flake:
    nix flake update

print-drvs HOSTNAME:
    nix derivation show --recursive $(nix build --print-out-paths .#nixosConfigurations.{{HOSTNAME}}.config.system.build.toplevel) > drvs.txt
    chmod 600 drvs.txt
    rm -rf result

rebuild-system HOSTNAME:
    sudo nixos-rebuild switch --flake .#{{HOSTNAME}}

rebuild-home USER:
    home-manager switch --flake .#{{USER}}

format-drive DISKO_FILE:
    sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount {{DISKO_FILE}}

mount-drive DISKO_FILE:
    sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode mount {{DISKO_FILE}}

clean-store:
    @echo "Running Nix store cleanup..."
    sudo nix profile wipe-history --older-than 14d
    sudo nix store gc
    sudo nix store optimise
