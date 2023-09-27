require("Comment").setup()
require("which-key").setup()
require("todo-comments").setup()
require("nvim-tree").setup()
require("telescope").load_extension("fzf")
require("gitsigns").setup()
require("neotest").setup({
  adapters = {
    require("neotest-rust")
  }
})

local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr, desc = "Hover actions" })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr, desc = "Code actions"})
      vim.keymap.set("n", "<Leader>oc", rt.open_cargo_toml.open_cargo_toml, { buffer = bufnr, desc = "[O]pen [C]argo"})
      vim.keymap.set("n", "<Leader>rr", rt.runnables.runnables, { buffer = bufnr, desc = "[R]ust [R]unnables"})
      vim.keymap.set("n", "<Leader>rd", rt.debuggables.debuggables, { buffer = bufnr, desc = "[R]ust [D]ebuggables"})
      rt.inlay_hints.enable()
    end,
  },
})

require("trouble").setup({
  use_diagnostic_signs = true
})
