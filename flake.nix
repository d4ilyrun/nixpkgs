{
  description = "My system config.";

  inputs = {
    nixpkgs = {
      type = "github";
      owner = "NixOs";
      repo = "nixpkgs";
      ref = "nixos-21.11";
    };

    home-manager = {
      type = "github";
      owner = "nix-community";
      repo = "home-manager";
      ref = "release-21.11";
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
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    discord.url = "github:InternetUnexplorer/discord-overlay";
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
    let
      system = "x86_64-linux";
      stateVersion = "21.11";

      my = import ./config;
      username = my.config.username;
      homeDirectory = my.config.home;

      overlays = import ./pkgs/overlays;

      lib = nixpkgs.lib;
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = with inputs; [
          neovim-nightly.overlay
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
          homeConfig = imports: home-manager.lib.homeManagerConfiguration {
            inherit pkgs system username homeDirectory stateVersion;
            configuration = {
              inherit imports;
              programs.home-manager.enable = true;
              news.display = "silent";
            };
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
