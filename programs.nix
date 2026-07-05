{ config, pkgs, inputs, fetchgit, ... }:

{
  imports = [
    inputs.noctalia.homeModules.default
    inputs.nixcord.homeModules.nixcord
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [
        "sudo" "safe-paste" "git"
        "zoxide" "zsh-interactive-cd"
      ];
      theme = "refined";
    };

    plugins = [ ];

    shellAliases = {
      ls = "eza -laTL 2 --git --git-repos --icons=always --hyperlink ";
      cp = "cp -rv ";
      cat = "bat";
      hm = "home-manager";
      hms = "home-manager switch --impure";
      nv = "nvim";
      lg = "lazygit";
      reboot = "sudo systemctl reboot";
      poweroff = "sudo systemctl poweroff";
      alien = "nix-alien";
      nsh = "nix-shell --command 'zsh; exit'";
      ngc = "nix-collect-garbage";
      open = "xdg-open";
      cnf = "command-not-found";
      inx = "echo $IN_NIX_SHELL";
      leptos = "cargo leptos";
    };

    initContent = ''
      export PATH=$PATH:$HOME/.bin:$HOME/.cargo/bin/:$HOME/.dotnet/tools/
      export EDITOR=nvim

      function cargo() {
        if [ $1 = "run" ] ||
        [ $1 = "check" ] ||
        [ $1 = "test" ]; then
          command cargo mommy "$@"
        else
          command cargo "$@"
        fi
      }

      eval $(zoxide init zsh)
      eval $(fzf --zsh)
      warp-cli connect > /dev/null
    '';

    history = {
      size = 5000;
      ignoreAllDups = true;
      path = "$HOME/.zsh_history";
    };
  };

  programs.nushell = {
    enable = true;
    extraConfig = ''
      let carapace_completer = {|spans|
        carapace $spans.0 nushell ...$spans | from json
      }

      source-env ~/.df/mocha.nu

      $env.NUPM_HOME = ($nu.default-config-dir | path join "nupm")
      $env.NU_COMPLETIONS = $"($env.HOME)/.local/share/nushell/completions"

      $env.PATH ++= [
        ($env.NUPM_HOME | path join "modules")
      ]

      const NU_LIB_DIRS = [
        ($nu.default-config-dir | path join "scripts")
        ($nu.default-config-dir | path join "nupm/modules")
        "/home/amida/.local/share/nushell/completions"
      ]

      $env.config = {
        show_banner: false
        completions: {
          case_sensitive: false
          quick: true
          partial: true
          algorithm: "fuzzy"
          external: {
            enable: true
            max_results: 100
            completer: $carapace_completer
          }
        }
      }

      $env.IN_NIX_SHELL = ""
      $env.PROMPT_MULTILINE_INDICATOR = "::"
      $env.PROMPT_COMMAND_RIGHT = {||}
      $env.PROMPT_INDICATOR = {
        if $env.LAST_EXIT_CODE != 0 {
          $"(ansi red)❯ (ansi reset)"
        } else {
          "❯ "
        }
      }
      $env.PROMPT_COMMAND = {
        mut pwd = $env.PWD | str replace $env.HOME "~"
        mut prompt = $"\n(ansi '#FFAEAE')($pwd)(ansi reset)\n"

        if (".git" | path exists) {
          let branch = git branch --show-current
          let pink_bold = {
            fg: "#FFAEAE"
            attr: b
          }
          $pwd = $env.PWD | path basename
          let dir_color = ansi -e $pink_bold
          let reset = ansi reset
          let gray = ansi '#777777'
          mut nix_shell = ""

          if ($env.IN_NIX_SHELL | is-not-empty) {
            $nix_shell = $"(ansi '#7EB7E2')nix:(ansi '#4F73BC')($env.IN_NIX_SHELL)"
          }

          $prompt = $"\n($dir_color)($pwd)($reset) ($gray)git:($branch) ($nix_shell)($reset)\n"
        }

        $prompt
      }
      $env.config.table.mode = 'light'

      $env.config.buffer_editor = 'nvim'

      if not ("~/.zoxide.nu" | path exists) { touch ~/.zoxide.nu }
      zoxide init nushell | save -f ~/.zoxide.nu
      source ~/.zoxide.nu

      alias cp = cp -rvp
      alias md = mkdir
      alias rd = rmdir
      alias hm = home-manager
      alias hms = home-manager switch --impure
      alias lg = lazygit
      alias reboot = sudo systemctl reboot
      alias poweroff = sudo systemctl poweroff
      alias alien = nix-alien
      alias nsh = nix-shell --command "nu; exit"
      alias ngc = nix-collect-garbage
      alias xopen = xdg-open
      alias cnf = command-not-found
      alias inx = echo $env.IN_NIX_SHELL
      alias leptos = cargo leptos
      alias lp = eza -laTL 1 --git --color=always --icons=always --no-quotes
      alias rar = unrar
      alias copy = wl-copy
      alias paste = wl-paste
      alias warp = warp-cli

      def l [lv?: int] {
        let lv = match $lv {
          null | 0 => 1,
          _  => $lv,
        }

        eza -laTL $lv --git --color=always --icons=always --no-user --no-quotes --no-permissions
      }

      def lp [lv?: int] {
        let lv = match $lv {
          null | 0 => 1,
          _  => $lv,
        }

        eza -laTL $lv --git --color=always --icons=always --no-quotes
      }

      def nv [...args] {
        let sesh = "Session.vim"
        if ($sesh | path exists) {
          nvim -S $sesh -c "normal zz" ...$args
        } else {
          nvim ...$args
        }
      }

      def sftpmnt [] {
        let conn = (nmcli networking connectivity | complete | get stdout)
        mut try_count = 0
        def mnt [] {
          let result = sftpman -v mount shrine | complete
          let stdout = $result.stdout | save -a ~/sftpman.log
          let stderr = $result.stderr | save -a ~/sftpman.log
          $result.exit_code
        }

        match $conn {
          "full" => {
            print $'Remote dir mounted on ($env.HOME)/shrine succesfully'
            mnt
          }
          _ => (while $try_count < 3 {
            sleep 10sec
            let exit_code = mnt
            if $exit_code != 0 {
              print $'Failed to mount remote dir to ($env.HOME)/shrine.'
              if $try_count < 3 { print "Retrying..." }
              $try_count += 1
              sftpmnt
            } else {
              print $'Remote dir mounted on ($env.HOME)/shrine succesfully'
              break
            }
          })
        }
      }

      def binit [] {
        sftpmnt
        btop
      }

      def suspend [] {
        fusermount -u ~/shrine
        sudo systemctl suspend
        sftpmnt 
      }

      # crude implementation of zsh command substitution
      def "&" [prev: string, new: string] {
        let last_cmd = (history | last 1 | get command.0)
        let new_cmd = ($last_cmd | str replace $prev $new)
        nu -c $new_cmd
      }

      def ".."    [] { cd - }
      def "..."   [] { for _ in 2 { cd - } }
      def "...."  [] { for _ in 3 { cd - } }
      def "....." [] { for _ in 4 { cd - } }

      mkdir ($nu.data-dir | path join "vendor/autoload")
      starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
    '';
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      command_timeout = 3000;
      scan_timeout = 60;
    };
  };

  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withRuby = false;
    withPython3 = false;
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
      vim-go
      Ionide-vim
    ];
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Amida Kurniawati";
        email = "aaaamida6747@gmail.com";
      };
      diff.external = "difft";
    };
  };

  programs.helix = {
    enable = false;
    extraPackages = with pkgs; [ nil ];
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  programs.zed-editor = {
    enable = true;
    package = pkgs.zed-editor.fhsWithPackages (pkgs: (with pkgs; [
      openssl
      libz
      nerd-fonts.iosevka-term-slab
    ]));
  };

  programs.kitty.enable = true;

  programs.nixcord = {
    enable = true;
    discord.vencord.enable = true;

    config.plugins = {
      betterFolders.enable = true;
      biggerStreamPreview.enable = true;
      blurNsfw.enable = true;
      callTimer.enable = true;
      characterCounter.enable = true;
      clearUrls.enable = true;
      copyFileContents.enable = true;
      crashHandler.enable = true;
      customRpc.enable = true;
      fakeNitro.enable = true;
      fixImagesQuality.enable = true;
      gifPaste.enable = true;
      imageLink.enable = true;
      imageZoom.enable = true;
      ircColors = {
        enable = true;
        applyColorOnlyInDms = true;
      };
      messageLogger.enable = true;
      noProfileThemes.enable = true;
      petpet.enable = true;
      pinDms = {
        enable = true;
        userBasedCategoryList = {
          "1128220398719348808" = [ ];
        };
      };
      platformIndicators = {
        enable = true;
        messages = false;
      };
      shikiCodeblocks = {
        enable = true;
        bgOpacity = 80.0;
      };
      showHiddenChannels.enable = true;
      unindent.enable = true;
      youtubeAdblock.enable = true;
    };
    extraConfig.plugins = {
      platformIndicators = {
        badges = true;
      };
      showHiddenChannels = {
        hideUnreads = true;
      };
    };
  };

  programs.tmux = {
    enable = true;
    terminal = "xterm-direct";
  };

  programs.btop.enable = true;
  programs.noctalia.enable = true;

	programs.yazi = {
		enable = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
    package = pkgs.yazi.override { _7zz = pkgs._7zz-rar; };
    shellWrapperName = "yy";
    settings.mgr = {
      ratio = [ 1 3 4 ];
      show_hidden = true;
      show_symlink = true;
      scrolloff = 255;
    };

    keymap.mgr.prepend_keymap = [
      { on = [ "T" ]; run = "plugin toggle-pane min-preview"; }
      { on = [ "U" ]; run = "plugin toggle-pane min-parent"; }
    ];

    plugins = {
      toggle-pane = pkgs.yaziPlugins.toggle-pane;
    };
	};

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [ wlrobs ];
  };

  programs.sftpman = {
    enable = true;
    defaultSshKey = "/home/amida/.ssh/shrine_key";
    mounts.shrine = {
      user = "shrine";
      host = "100.65.243.20";
      mountOptions = [
        "ServerAliveInterval=15"
        "reconnect"
        "allow_other"
        "default_permissions"
        "_netdev"
        "uid=1000"
        "gid=100"
      ];
      mountPoint = "/shrine";
      mountDestPath = "/home/amida/shrine";
    };
  };
}
