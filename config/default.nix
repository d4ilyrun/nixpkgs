rec {

  config = rec {
    machine = "desktop";
    username = "leo";
    home = "/home/${config.username}";
    nixpkgs = "${config.home}/.config/nixpkgs";
  };
}
