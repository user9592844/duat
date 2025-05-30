drvs HOSTNAME:
    nix derivation show --recursive $(nix build --print-out-paths .#nixosConfigurations.{{HOSTNAME}}.config.system.build.toplevel) > drvs.txt
    chmod 600 drvs.txt
    rm -rf result

format-drive DISKO_FILE:
    sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount {{DISKO_FILE}}

mount-drive DISKO_FILE:
    sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode mount {{DISKO_FILE}}
