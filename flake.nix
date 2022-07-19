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
      nixosConfigurations =
      let
        systemConfig = modules: lib.nixosSystem { inherit system modules; };
      in
      {
        desktop = systemConfig [ ./config/desktop/configuration.nix ];
        laptop = systemConfig [ ./config/laptop/configuration.nix ];
        yaka = systemConfig [ ./config/yaka/configuration.nix ];
      };

      homeConfigurations =
      let
        homeConfig = imports: home-manager.lib.homeManagerConfiguration {
          inherit system username homeDirectory stateVersion;
          configuration = {
            inherit imports;
            programs.home-manager.enable = true;
            nixpkgs.config.allowUnfree = true;
            news.display = "silent";
          };
        };
      in
      {
        desktop = homeConfig [ ./user/leo.nix ./config/desktop ];
        laptop = homeConfig [ ./user/leo.nix ./config/laptop ];
        yaka = homeConfig [ ./user/leo.nix ./config/yaka ];
        empty = homeConfig [ ];

        leo = self.homeConfigurations.empty;
      };
    };
}
