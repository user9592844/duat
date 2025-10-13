# Flake commands
update-flake:
    nix flake update

update-flake-input INPUT:
    nix flake update {{INPUT}}

show-outputs:
    nix flake show

# System rebuild commands
rebuild-system HOSTNAME:
    sudo nixos-rebuild switch --flake .#{{HOSTNAME}}

rebuild-home:
    home-manager switch --flake .

# Disko commands
format-drive DISKO_FILE:
    sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount {{DISKO_FILE}}

mount-drive DISKO_FILE:
    sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode mount {{DISKO_FILE}}

# Hygiene commands
clean-store:
    @echo "Running Nix store cleanup..."
    sudo nix profile wipe-history --older-than 14d
    sudo nix store gc
    sudo nix store optimise

check-format:
    nixpkgs-fmt --check .

lint-config:
    statix check -i hardware-configuration.nix

check-deadcode:
    deadnix . --exclude hardware-configuration.nix
