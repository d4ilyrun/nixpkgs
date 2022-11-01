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
      stateVersion = "22.11";

      my = import ./config;
      username = my.config.username;
      homeDirectory = my.config.home;

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
    in
    {
      nixosConfigurations =
        let
          systemConfig = modules: lib.nixosSystem { inherit system modules pkgs; };
        in
        {
          desktop = systemConfig [ ./config/desktop/configuration.nix ];
          laptop = systemConfig [ ./config/laptop/configuration.nix ];
          yaka = systemConfig [ ./config/yaka/configuration.nix ];
        };

      homeConfigurations =
        let
          homeConfig = imports: home-manager.lib.homeManagerConfiguration rec {
            inherit pkgs;
            extraSpecialArgs = { inherit my; inherit (inputs) spicetify-nix; };
            modules = imports;
          };
        in
        {
          desktop = homeConfig [ ./user/leo.nix ./config/desktop ];
          laptop = homeConfig [ ./user/leo.nix ./config/laptop ];
          yaka = homeConfig [ ./user/leo.nix ./config/yaka ];
          empty = homeConfig [ ];

          "${username}" = self.homeConfigurations.empty;
        };
    };
}
