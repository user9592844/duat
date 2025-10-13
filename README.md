# Duat
**Duat** is my personal NixOS configuration repository for a declarative multi-host and multi-user system. The goal is to provide a reproducible, modular configuration that can be easily scaled to new systems or customised for different needs.

While this is primarily the repository for my homelab, it can also serve as a template or starting point for others. However, I will disclaim up-front that I am not an expert nor an IT professional and make no claims of having implemented things to best-practices.

## Features
- **Multi-Host System Configuration**: The flake defines each host under `/hosts/hosts/` as an entrypoint for building system configurations. Each host has its own configuration to allow centralised management of multiple systems (e.g. desktops, laptops, servers, kiosks, etc.) in a single repository.
- **Multi-User System Configuration**: The hosts system configurations define which users are to be configured per host. This allows each user module to be reused in any host, and any host to contain any user.
- **Home Manager Integration**: User-specific configurations (like shell setup, editors, and dotfiles) are managed with [Home Manager](https://github.com/nix-community/home-manager) running as a standalone package, with the entrypoint being under `home/`. This allows each user to customise their environment (applications, themes, etc.) declaratively without requiring full-system rebuilds or users to have elevated permissions.
- **Modular Structure**: Configuration is split into modules and profiles. Common settings and packages are factored into reusable NixOS modules so multiple hosts can share standard configurations (service sandboxing, security implementations, etc.). Host-specific details (like hardware settings or unique packages) live in their own files. This makes the setup easier to maintain and customise.
- **Reproducible and Version-Controlled**: Using Nix and flakes ensures that all dependencies (like NixOS/nixpkgs and Home Manager) are pinned in a flake.lock for reproducibility. You can rebuild the same system configuration reliably on any machine at any time. Everything is tracked in Git to allow for a complete history of changes.
- **Automation as a Foundation**: The configuration also makes use of GitHub Actions for integrtation of changes into the configuration. Upon making a Pull Request, the changes are automatically passed through formatting and linting checks for cleanliness and readibility, and a basic `nix flake check` is performed to sanity-check that no low-hanging mistakes are present.
- **Secrets as a Feature**: The repository also attempts to implement good hygiene through the utilisation of the [sops-nix](https://github.com/Mic92/sops-nix) NixOS and Home Manager modules. Secrets are divided into system secrets such as user passwords, and user secrets such as ssh keys. System secrets are decrypted by using the host identification key assigned to each host. Users however are able to bring their own ssh key to use for decrypting their own secrets. This allows for centralised management of secrets, but users can feel safe that theirs are protected by a key they generate/manage.

## Repository Structure
The overall repository structure utilises the flake.nix as the main entrypoint, and top-level directories to organise configurations.
```
├── flake.lock
├── flake.nix
├── home
├── hosts
├── justfile
├── lib
├── LICENSE
├── modules
├── pkgs
└── README.md
```
Within this structure a few key files and directories exist:
- **flake.nix**: The entrypoint to the configurations (both NixOS and Home Manager). This file defines the flake inputs such as nixpkgs, and the outputs such as Home Manager configuration. Essentially, this file unifies all other files in the repository into a single cohesive unit.
- **hosts/**: The directory containing the NixOS configurations. Each machine has its own entrypoint within `hosts/hosts/`, and modules within `hosts/` can be accessed by any host configuration. All hosts
- **modules/**: This directory holds shared NixOS modules. Each file contained within represents a modular configuration piece (a set of options and a package). For instance, [duat-system.nix](modules/duat-system.nix) is used to define several important parameters for the configuration of hosts such as the list of users.
- **home/**: All Home Manager configurations are contained in this directory in a one-to-one mapping between directories and users (i.e. user imhotep has one `home/imhotep` directory). User configurations are also configurable based on host through the use of a factory design pattern. Each `<host>.nix` in the user's configurations calls a `common.nix` to grab the standard configurations.
- **justfile**: The [just](https://github.com/casey/just) command runner is used to allow for the translation of system management commands into a more plain-English syntax. One example of this is a system rebuild. The string `sudo nixos-rebuild switch --flake .#maat` becomes `just rebuild-system maat`

## Prerequisites
Before using or applying this configuration please ensure you have the following:
- NixOS (24.11 or later)
- Nix with flakes enabled
- Git

## Customisation
One of the main goals of this repository structure is how easy it is to customise or extend the configuration.
### Adding or Removing Packages
To change the software currently included in the repository, edit the appropriate hosts or home-manager configuration file. To add a new one, place it in the hosts or home directory according to the categorisation schema therein, and ensure it is imported by the host/user.

### Enabling/Disabling Features
The configuration likely has modules for various features (window managers, editors, etc.) which may have varying levels of usefulness in different scenarios. To enable, simply ensure they're imported by the host/user and they'll get built the next time a rebuild occurs.

### Adding a New Host
To create a new host simply make a directory in the `hosts/hosts/` subdirectory, and place a `default.nix` and `hardware-configuration.nix` in the directory. The host will be then be available to build using `just rebuild-system <HOSTNAME>`.

### Adding a New User
To create a new user, simply make a directory in the `hosts/common/users/` subdirectory, and place a `default.nix` in the directory. The host will now be available for inclusion in the userList of any existing host. Additionally, if the user desires using home-manager for personal configuration management, similarly create a user directory `home/`.

## Contributing
Contributions are welcome! I consider myself perpetually a student in everything I do, and would welcome constructive criticism! If you have suggestions, find a bug, or want to improve this configuration please feel free to open an issue or submit a pull request on GitHub. Keep in mind this is my personal configuration so changes that align with best practices and general improvements are more likely to be merged. If you fork this repo for your own use, I'd love to hear about any customisations/changes you've made!

## License
This repository uses the BSD-3-Clause License. Please see the [LICENSE](LICENSE) for more information.
