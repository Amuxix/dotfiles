return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
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
    },
}
