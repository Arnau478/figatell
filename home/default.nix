{ pkgs, ... }:

{
  home.packages = with pkgs; [
    signal-desktop
    pavucontrol
    slurp
    wl-clipboard
  ];

  wayland.windowManager.river = {
    enable = true;
    settings = {
      keyboard-layout = "es";
      border-width = 2;
      declare-mode = [
        "normal"
      ];
      map = {
        normal = {
          "Super+Control Q" = "exit";
          "Super+Shift Q" = "close";
          "Super Return" = "spawn ${pkgs.alacritty}/bin/alacritty"; # TODO: ghostty
          "Super R" = "spawn '${pkgs.wofi}/bin/wofi --show drun'";
          "Super+Shift Return" = "zoom";
          "Super 1" = "set-focused-tags 1";
          "Super 2" = "set-focused-tags 2";
          "Super 3" = "set-focused-tags 4";
          "Super+Shift 1" = "set-view-tags 1";
          "Super+Shift 2" = "set-view-tags 2";
          "Super+Shift 3" = "set-view-tags 3";
        };
      };
      default-layout = "rivertile";
      spawn = [
        "${pkgs.river}/bin/rivertile"
      ];
      input = {
        "*_Touchpad" = {
          natural-scroll = "enabled";
          tap = "enabled";
        };
      };
    };
  };

  programs.wofi = {
    enable = true;
    settings = {
      insensitive = true;
    };
  };

  programs.git = {
    enable = true;
    userName = "Arnau478";
    userEmail = "arnauxabia@gmail.com";
    signing = {
      signByDefault = true;
      key = "~/.ssh/id_ed25519.pub";
    };
    extraConfig = {
      pull.rebase = true;
      init.defaultBranch = "master";
      gpg.format = "ssh";
    };
  };

  programs.firefox = {
    enable = true;
  };

  programs.nixvim = {
    enable = true;
    colorschemes.catppuccin.enable = true;
    clipboard.providers.wl-copy.enable = true;
    opts = {
      number = true;
      cursorline = true;
      tabstop = 4;
      shiftwidth = 4;
      softtabstop = 0;
      expandtab = true;
      smarttab = true;
    };
    autoCmd = [
      {
        event = "FileType";
        pattern = "nix";
        command = "setlocal tabstop=2 shiftwidth=2";
      }
    ];
    plugins = {
      cmp = {
        enable = true;
        settings = {
          sources = [
            {
              name = "nvim_lsp";
              keyword_length = 1;
            }
            {
              name = "path";
              keyword_length = 0;
            }
            {
              name = "buffer";
              keyword_length = 4;
            }
          ];
          mapping = {
            "<Up>" = "cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Select})";
            "<Down>" = "cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Select})";
            "<CR>" = "cmp.mapping.confirm({select = false})";
            "<C-Space>" = "cmp.mapping.confirm({select = true})";
          };
        };
      };

      lsp = {
        enable = true;
        servers = {
          zls.enable = true;
          clangd.enable = true;
          eslint.enable = true;
          nixd.enable = true;
        };
      };

      lualine = {
        enable = true;
      };
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim"; # TODO: Add this into nixvim
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      function fish_prompt
        string join "" -- (set_color green) $PWD " " (set_color normal) "> "
      end
    '';
  };

  systemd.user.startServices = "sd-switch";
}
