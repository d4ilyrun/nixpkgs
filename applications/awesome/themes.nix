{ lib, ... }:

with lib;

rec {

  concatColorStr = (color:
    concatStringsSep "\n" (attrsets.mapAttrsToList
      (name: value: "${name} = ${value}")
      color
    )
  );

  writeColorTheme = (name: color:
    let
      parts = attrsets.attrVals [ "primary" "normal" "bright" ] color;

      primary = elemAt parts 0;
      normal = elemAt parts 1;
      bright = elemAt parts 2;
    in
    concatStringsSep "\n" [
      (concatColorStr normal)
      (concatColorStr bright)
    ]
  );
}
