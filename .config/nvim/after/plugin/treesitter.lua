require('nvim-treesitter.configs').setup {
  ensure_installed = {
    -- Basic vim stuff
    "vim",
    -- "help",
    "query",
    "lua",

    -- Main languages
    "java",
    "scala",

    -- Webdev
    "python",
    "javascript",
    "typescript",

    -- Ruby
    "ruby",

    -- Docker
    "dockerfile",

    -- Scripting
    "bash",

    -- Git
    "git_config",
    "git_rebase",
    "gitattributes",
    "gitcommit",
    "gitignore",

    -- Query
    "graphql",
    "sql",

    -- Data formats
    "html",
    "http",
    "css",
    "json",
    "regex",
    "toml",
    "yaml",
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  rainbow = {
    enable = true,

    -- Which query to use for finding delimiters
    query = 'rainbow-parens',

    -- Highlight the entire buffer all at once
    strategy = require('ts-rainbow').strategy.global,
    colors = {
      "rainbowcol1",
      "rainbowcol2",
      "rainbowcol3",
      "rainbowcol4",
      "rainbowcol5",
      "rainbowcol6",
    }
  }
}
