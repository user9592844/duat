drvs HOSTNAME:
    nix derivation show --recursive $(nix build --print-out-paths .#nixosConfigurations.{{HOSTNAME}}.config.system.build.toplevel) > drvs.txt
    chmod 600 drvs.txt
    rm -rf result
