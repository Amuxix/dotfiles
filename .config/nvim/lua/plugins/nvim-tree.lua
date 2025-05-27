local function setup()
  local function attach(bufnr)
    local api = require("nvim-tree.api")

    local function opts(desc)
      return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    local git_add = function()
      local node = api.tree.get_node_under_cursor()
      local gs = node.git_status.file

      -- If the current node is a directory get children status
      if gs == nil then
        gs = (node.git_status.dir.direct ~= nil and node.git_status.dir.direct[1])
             or (node.git_status.dir.indirect ~= nil and node.git_status.dir.indirect[1])
      end

      -- If the file is untracked, unstaged or partially staged, we stage it
      if gs == "??" or gs == "MM" or gs == "AM" or gs == " M" then
        vim.cmd("silent !git add " .. node.absolute_path)

      -- If the file is staged, we unstage
      elseif gs == "M " or gs == "A " then
        vim.cmd("silent !git restore --staged " .. node.absolute_path)
      end

      api.tree.reload()
    end
    -- custom mappings
    vim.keymap.set("n", "ga", git_add, opts("Git Add"))
  end


  require("nvim-tree").setup({
    sync_root_with_cwd = true,
    view = {
      width = {
        min = 30,
        max = 60,
      },
    },
    renderer = {
      full_name = true,
      group_empty = true,
      special_files = {},
      symlink_destination = false,
      indent_markers = {
        enable = true,
      },
      highlight_git = "name",
      highlight_modified = "icon",
      icons = {
        git_placement = "before",
        show = {
          git = true,
        },
      },
    },
    update_focused_file = {
      enable = true,
      update_root = true,
      ignore_list = { "help" },
    },
    diagnostics = {
      enable = true,
      show_on_dirs = true,
    },
    filters = {
      git_ignored = false,
      custom = {
        "^.git$",
      },
    },
    actions = {
      change_dir = {
        enable = false,
        restrict_above_cwd = true,
      },
      open_file = {
        resize_window = true,
        window_picker = {
          chars = "asdfghjkl",
        },
      },
    },
    on_attach = attach,
  })

  local function open_nvim_tree()
    require("nvim-tree.api").tree.open()
  end

  vim.keymap.set("n", "<leader>a", "<cmd>NvimTreeFindFile<cr>")
  vim.keymap.set("n", "<leader>i", "<cmd>NvimTreeFindFileToggle<cr>")
  vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("open_nvimtree", {}),
    desc = "Open Nvim-tree on startup",
    pattern = "*",
    callback = function()
        open_nvim_tree()
    end,
  })
end

return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = {
    "NvimTreeOpen",
    "NvimTreeToggle",
    "NvimTreeFindFile",
    "NvimTreeFindFileToggle",
  },
  keys = {
    "<leader>a",
    "<leader>i",
  },
  config = setup,
}
