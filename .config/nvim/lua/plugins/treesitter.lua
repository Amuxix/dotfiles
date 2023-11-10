return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = {
        ensure_installed = {
            -- Basic vim stuff
            "vim",
            "query",
            "lua",

            -- Main languages
            "java",
            "scala",
            "python",
            "c",

            -- Webdev
            "javascript",
            "typescript",

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
            "json",
            "regex",
            "toml",
            "yaml",
        },
        indent = { enable = true },
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
          },
        },
    },
}
