{ pkgs, ... }: {
  nclipper-vim = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "nclipper.vim";
    src = pkgs.fetchFromGitHub {
      owner = "astutecat";
      repo = "nclipper.vim";
      rev = "25872ddcfa2c667c21ecbddf0bed09e2eb716027";
      sha256 = "084p9vh6rhd7b4rrfaq9lkx9fsrwravvddicmwcr0b5g9hfqm2w3";
    };
  };

  vim-mercenary = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "vim-mercenary";
    src = pkgs.fetchFromGitHub {
      owner = "jlfwong";
      repo = "vim-mercenary";
      rev = "fce25a5fe8faba5cb3b9b71ccba14ac10c3a2af2";
      sha256 = "sha256:9Tq+vcoLSYxMsRoqTJYpg+8thxMXPhNO/aGr6Bcvq+A=";
    };
  };

  nvim-scrollbar = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "nvim-scrollbar";
    src = pkgs.fetchFromGitHub {
      owner = "petertriho";
      repo = "nvim-scrollbar";
      rev = "ce0df6954a69d61315452f23f427566dc1e937ae";
      sha256 = "sha256:EqHoR/vdifrN3uhrA0AoJVXKf5jKxznJEgKh8bXm2PQ=";
    };
  };

  nvim-treesitter-endwise = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "nvim-treesitter-endwise";
    src = pkgs.fetchFromGitHub {
      owner = "RRethy";
      repo = "nvim-treesitter-endwise";
      rev = "0cf4601c330cf724769a2394df555a57d5fd3f34";
      sha256 = "sha256:Pns+3gLlwhrojKQWN+zOFxOmgRkG3vTPGoLX90Sg+oo=";
    };
  };

  obsidian-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "obsidian.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "epwalsh";
      repo = "obsidian.nvim";
      rev = "c7e441320280e2b0e51da1efcc241805ef715c34";
      sha256 = "sha256:EsqIL8pHx/q+spz4TXiDpbqA4sbRM0ZSn7gfovtELcI=";
    };
  };

  nvim-navic = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "nvim-navic";
    src = pkgs.fetchFromGitHub {
      owner = "SmiteshP";
      repo = "nvim-navic";
      rev = "40c0ab2640a0e17c4fad7e17f260414d18852ce6";
      sha256 = "sha256:SCeDNVP8eYnhNcwShIs2IZI80cXAoIiWLHBLatFFmaQ=";
    };
  };

  vim-lengthmatters = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "vim-lengthmatters";
    src = pkgs.fetchFromGitHub {
      owner = "whatyouhide";
      repo = "vim-lengthmatters";
      rev = "98afd5af24e13d3aeaa6442ee41bbf6685595961";
      sha256 = "sha256:H/UOFzSVyMovUFR7gS8mUVBzVyBpyVUqUtVP49kz53U=";
    };
  };

  vim-rfc = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "vim-rfc";
    src = pkgs.fetchFromGitHub {
      owner = "mhinz";
      repo = "vim-rfc";
      rev = "5a7dfe4bc02fd0b10beb0026effde5c40d2ca648";
      sha256 = "sha256:6kJ5xbYlPLZP0jeJ1tup1BWsfSrgpaB3YUFk3foj/lg=";
    };
  };

  tree-sitter-just = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "tree-sitter-just";
    src = pkgs.fetchFromGitHub {
      owner = "IndianBoy42";
      repo = "tree-sitter-just";
      rev = "8af0aab79854aaf25b620a52c39485849922f766";
      sha256 = "sha256:hYKFidN3LHJg2NLM1EiJFki+0nqi1URnoLLPknUbFJY=";
    };
  };

  promise-async = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "promise-async";
    src = pkgs.fetchFromGitHub {
      owner = "kevinhwang91";
      repo = "promise-async";
      rev = "70b09063cdf029079b25c7925e4494e7416ee995";
      sha256 = "sha256:rGbi5nCCz1qO6CzoWxbze8iKWP6baqIZBd/Je2LU6jw=";
    };
  };

  nvim-ufo = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "nvim-ufo";
    src = pkgs.fetchFromGitHub {
      owner = "kevinhwang91";
      repo = "nvim-ufo";
      rev = "a346e88c776a7089291c883705c5cd8a6ce67558";
      sha256 = "sha256:OThSxKXD8YqY9SxqYOrG3hHYcMHL6copyfuUj6HxjZw=";
    };
  };

}
