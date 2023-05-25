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

  {
    plugin = nerdtree;
    config = builtins.readFile ./nerdtree.vim;
  }

  {
    plugin = undotree;
    config = import ./undotree.nix { inherit vimconf; };
  }

  {
    plugin = telescope-nvim;
    type = "lua";
    config = builtins.readFile ./telescope.lua;
  }

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

  {
    plugin = null-ls-nvim;
    type = "lua";
    config = builtins.readFile ./null-ls.lua;
  }

  {
    plugin = vim-rooter;
    config = builtins.readFile ./rooter.vim;
  }

  diff-fold
  BufOnly-vim

  fugitive

  vim-commentary
  vim-indent-object

  {
    plugin = vdebug;
    config = builtins.readFile ./vdebug.vim;
  }

  delimitMate
  vim-css-color
  /* awesome-vim-colorschemes */
  spacecamp

  vim-devicons

  {
    plugin = nvim-lspconfig;
    type = "lua";
    config = builtins.readFile ./lsp-config.lua;
  }
  {
    plugin = nvim-compe;
    type = "lua";
    config = builtins.readFile ./nvim-compe.lua;
  }
  {
    plugin = lsp_signature-nvim;
    type = "lua";
    config = builtins.readFile ./lsp-signature.lua;
  }
  vim-vsnip

  vim-ccls
]
