{ config
, pkgs
, vimconf
, ...
}:

let
  syntax-nix = pkgs.vimUtils.buildVimPluginFrom2Nix rec {
    pname = "syntax-nix";
    version = "7d23e97d13c40fcc6d603b291fe9b6e5f92516ee";
    src = pkgs.fetchFromGitHub {
      owner = "LnL7";
      repo = "vim-nix";
      rev = version;
      sha256 = "sha256-W6ExP+iDNo5T8XazxHRpUiECGv+AU5PPoM4CmU7NV+0=";
    };
  };

  diff-fold = pkgs.vimUtils.buildVimPluginFrom2Nix rec {
    pname = "diff-fold";
    version = "48b4505c1b6f14ceb4e4be732aad337147ef36cd";
    src = pkgs.fetchFromGitHub {
      owner = "sgeb";
      repo = "vim-${pname}";
      rev = version;
      sha256 = "sha256-M3CAUueEhLD0J6sLUpRkFv+vK4aGYO+Xnokxmn+VxqU=";
    };
  };


  vdebug = pkgs.vimUtils.buildVimPluginFrom2Nix rec {
    pname = "vdebug";
    version = "v2.0.0";
    src = pkgs.fetchFromGitHub {
      owner = "joonty";
      repo = pname;
      rev = version;
      sha256 = "sha256-kobMC6TRFZcEbgFdOaBgXUzoeWQUrVzUKylN1N9nEnc=";
    };
  };

  spacecamp = pkgs.vimUtils.buildVimPluginFrom2Nix rec {
    pname = "spacecamp";
    version = "efe16a90234ae4c7714412d16f36af34284af321";
    src = pkgs.fetchFromGitHub {
      owner = "Martin-Lndbl";
      repo = pname;
      rev = version;
      sha256 = "sha256-I/oeZ+07KjMR8rqGk2+D7XeINk8bOP0quOSsuoatMLY=";
    };
  };

  tree-sitter-languages = languages: builtins.foldl'
    (
      acc: new:
        ''
          vim.treesitter.language.require_language("${new}", "${
            "${pkgs.tree-sitter.builtGrammars."tree-sitter-${new}"}/parser"
          }")${"\n\n"}${acc}
        ''
    ) ""
    languages;

in
with pkgs.vimPlugins; [

  # File tree
  {
    plugin = nerdtree;
    config = import ./nerdtree.nix { inherit vimconf; };
  }

  # Recent changes
  {
    plugin = undotree;
    config = import ./undotree.nix { inherit vimconf; };
  }

  # Searching
  {
    plugin = telescope-nvim;
    type = "lua";
    config = import ./telescope.nix { inherit vimconf; };
  }

  # Treesitter
  {
    plugin = nvim-treesitter;
    type = "lua";
    config = builtins.readFile ./treesitter.lua +
      tree-sitter-languages [
        /* "bash" */
        "c"
        "cpp"
        "css"
        "html"
        "graphql"
        "javascript"
        "json"
        "lua"
        /* "make" */
        "markdown"
        "nix"
        "rust"
        "java"
        "toml"
        "yaml"
        "latex"
      ];
  }

  syntax-nix
  i3config-vim
  typescript-vim

  # Allow non-native lsp sources
  {
    plugin = null-ls-nvim;
    type = "lua";
    config = builtins.readFile ./null-ls.lua;
  }

  # Changes working dir to project root
  # {
  #   plugin = vim-rooter;
  #   config = builtins.readFile ./rooter.vim;
  # }

  # Unload all buffers but current
  BufOnly-vim

  # Git inside nvim
  fugitive

  # Commentnig stuff out
  vim-commentary

  # Debugger
  # {
  #   plugin = vdebug;
  #   config = builtins.readFile ./vdebug.vim;
  # }

  # Autoclosing brackets
  delimitMate

  # Color name highlighter
  vim-css-color

  # Color scheme
  spacecamp

  # Native nvim Language-Server
  {
    plugin = nvim-lspconfig;
    type = "lua";
    config = builtins.readFile ./lsp-config.lua;
  }
  # Show method signatures
  {
    plugin = lsp_signature-nvim;
    type = "lua";
    config = builtins.readFile ./lsp-signature.lua;
  }
  # Auto completion
  {
    plugin = nvim-compe;
    type = "lua";
    config = builtins.readFile ./nvim-compe.lua;
  }

  vim-vsnip

  vim-ccls
] ++ vimconf.extraPlugins
