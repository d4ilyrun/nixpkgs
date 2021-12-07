{ lib, ... }:

{
    enable = true;
    enableBashIntegration = true;

    settings = {
        username = {
            # show_always = true;
        };

        hostname = {
            # ssh_only = false;
            style = "bold dimmed blue";
        };

        directory.truncation_length = 0;

        memory_usage.disabled = false;

        package  = {
            format = "[$symbol$version]($style) ";
            symbol = "📦 ";
        };

        status = {
            disabled = false;
            # format = "exit [$common_meaning$signal_name$maybe_int]($style) ";
            format = "[$int]($style) ";
            symbol = "🔴";
        };

        character = {
            success_symbol = "[➜](bold green)";
            error_symbol = "[➜](bold red)";
        };


        format = lib.concatStrings [
            "$username"
            "$hostname"
            "$shlvl"
            "$kubernetes"
            "$directory"
            "$git_branch"
            "$git_commit"
            "$git_state"
            "$git_status"
            "$hg_branch"
            "$docker_context"
            "$cmake"
            "$dart"
            "$elm"
            "$erlang"
            "$golang"
            "$helm"
            "$java"
            "$julia"
            "$kotlin"
            "$nim"
            "$nodejs"
            "$elixir"
            "$dotnet"
            "$ocaml"
            "$perl"
            "$php"
            "$purescript"
            "$python"
            "$ruby"
            "$rust"
            "$scala"
            "$swift"
            "$crystal"
            "$terraform"
            "$vagrant"
            "$zig"
            "$nix_shell"
            "$conda"
            "$memory_usage"
            "$openstack"
            "$custom"
            "$cmd_duration"
            "$lua"
            "$jobs"
            "$time"
            "$line_break"
            "$status"
            "$shell"
            "$character"
        ];
    };
}
