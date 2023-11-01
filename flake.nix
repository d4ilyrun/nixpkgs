{
  description = "My system config.";

  inputs = {
    nixpkgs = {
      type = "github";
      owner = "NixOs";
      repo = "nixpkgs";
      ref = "master";
    };

    home-manager = {
      type = "github";
      owner = "nix-community";
      repo = "home-manager";
      ref = "master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      type = "github";
      owner = "nix-community";
      repo = "NUR";
      ref = "master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # OVERLAYS
    neovim.url = "github:nix-community/neovim-nightly-overlay";
    discord.url = "github:InternetUnexplorer/discord-overlay";
    spicetify-nix.url = "github:the-argus/spicetify-nix";
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
    let
      system = "x86_64-linux";
      username = "leo"; # TODO: user module

      overlays = import ./pkgs/overlays;

      lib = nixpkgs.lib;
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = with inputs; [
          neovim.overlay
          discord.overlay
          nur.overlay
        ] ++ overlays;
      };

      myModules = [ ./pkgs/modules ./themes ];

      homeConfig = imports: home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = imports ++ myModules;
        extraSpecialArgs = {
          inherit (inputs) spicetify-nix;
          lib = nixpkgs.lib.extend (final: prev:
            prev // home-manager.lib // (import ./pkgs/lib {
              inherit pkgs;
              inherit (pkgs) stdenv;
              lib = prev;
            })
          );
        };
      };
    in
    {
      nixosConfigurations =
        let
          systemConfig = modules: lib.nixosSystem { inherit system modules pkgs; };
        in
        {
          desktop = systemConfig [ ./config/desktop/configuration.nix ];
          laptop = systemConfig [ ./config/laptop/configuration.nix ];
        };

      homeConfigurations =
        {
          desktop = homeConfig [ ./user/leo.nix ./config/desktop ];
          laptop = homeConfig [ ./user/leo.nix ./config/laptop ];

          empty = homeConfig [ ];

          "${username}" = self.homeConfigurations.empty;
        };

      checks."${system}" =
        let
          checkConfigModule = {
            dotfiles.repository = "${./.}";
          };

          checkConfig = modules:
            (homeConfig (modules ++ [ ./user/leo.nix checkConfigModule ])).activationPackage
          ;
        in
        {
          desktop = checkConfig [ ./config/desktop ];
          laptop = checkConfig [ ./config/laptop ];
        };
    };
}
