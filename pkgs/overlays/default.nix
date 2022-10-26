let
  overlay = (name: file: (self: super: {
    "${name}" = super.callPackage file { inherit (super); };
  }));
in
[
  (overlay "miru" ./miru.nix)
]
