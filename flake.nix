{
  description = "My system config.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-21.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      username = "leo";
      homeDirectory = "/home/${username}";
      stateVersion = "21.11";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [ ];
      };

      lib = nixpkgs.lib;
    in
    {
      nixosConfigurations = {
        desktop = lib.nixosSystem {
          inherit system;
          modules = [
            ./config/desktop/configuration.nix
          ];
        };

        laptop = lib.nixosSystem {
          inherit system;
          modules = [
            ./config/laptop/configuration.nix
          ];
        };
      };

      homeConfigurations = {
        desktop = home-manager.lib.homeManagerConfiguration {
          inherit system username homeDirectory stateVersion;

          configuration = {
            programs.home-manager.enable = true;
            nixpkgs.config.allowUnfree = true;
            news.display = "silent";
            imports = [
              ./user/leo.nix
              ./config/desktop
            ];
          };
        };

        laptop = home-manager.lib.homeManagerConfiguration {
          inherit system username homeDirectory stateVersion;

          configuration = {
            programs.home-manager.enable = true;
            nixpkgs.config.allowUnfree = true;
            news.display = "silent";
            imports = [
              ./user/leo.nix
              ./config/laptop
            ];
          };
        };

        empty = home-manager.lib.homeManagerConfiguration {
          inherit system username homeDirectory stateVersion;

          configuration = {
            programs.home-manager.enable = true;
            nixpkgs.config.allowUnfree = true;
            news.display = "silent";
          };
        };

        leo = self.homeConfigurations.empty;
      };
    };
}
