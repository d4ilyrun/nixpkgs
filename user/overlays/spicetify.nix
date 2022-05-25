{ spotify-unwrapped, lib, formats, spicetify-cli, config, extensions ? [ ] }:

let
  booleanToString = boolean: if boolean then "1" else "0";
  listToString = list: builtins.concatStringsSep "|" list;

  themes = "${fetchTarball "https://github.com/morpheusthewhite/spicetify-themes/archive/master.tar.gz"}/${config.theme}";

  configFile = (formats.ini { }).generate "config-xpui.ini" {
    AdditionalOptions = {
      custom_apps = listToString [ ];
      experimental_features = booleanToString true;
      extensions = listToString (map builtins.baseNameOf extensions);
      home_config = booleanToString true;
      sidebar_config = booleanToString true;
    };

    Backup = {
      version = "";
      "with" = "";
    };

    Preprocesses = {
      disable_sentry = booleanToString true;
      disable_ui_logging = booleanToString true;
      disable_upgrade_check = booleanToString true;
      expose_apis = booleanToString true;
      remove_rtl_rule = booleanToString true;
    };

    Patch = (if config.theme == "Bloom" then {
      "xpui.js_find_8008" = ",(\\w+=)32,";
      "xpui.js_repl_8008" = ",\${1}56,";
    } else { });

    Setting = {
      check_spicetify_upgrade = booleanToString false;
      color_scheme = config.colorScheme;
      current_theme = config.theme;
      inject_css = booleanToString true;
      overwrite_assets = booleanToString true;
      replace_colors = booleanToString true;
      spotify_launch_flags = listToString [ ];
      spotify_path = "SPOTIFY_PATH";
      prefs_path = "PREFS_PATH";
    };
  };

in
spotify-unwrapped.overrideAttrs (oldAttrs: {
  nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ]) ++ [ spicetify-cli ];

  postInstall = (oldAttrs.postInstall or "") + ''
    export HOME=$TMP

    spicetifyDir=$(dirname "$(spicetify-cli -c)")

    ln -s ${themes} $spicetifyDir/Themes/${config.theme}

    echo ${builtins.concatStringsSep " " extensions} >> /tmp/spicetify.log
    for source in ${builtins.concatStringsSep " " extensions}; do
      ln -s $source $spicetifyDir/Extensions/$(basename $source)
      echo $source = $(basename $source) >> /tmp/spicetify.log
    done

    touch $out/prefs
    cp -f ${configFile} $spicetifyDir/config-xpui.ini

    substituteInPlace $spicetifyDir/config-xpui.ini \
      --replace "PREFS_PATH" "$out/prefs" \
      --replace "SPOTIFY_PATH" "$out/share/spotify"

    spicetify-cli backup apply
  '';
})
