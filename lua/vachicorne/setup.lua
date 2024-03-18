require("Comment").setup()
require("which-key").setup()
require("todo-comments").setup()
require("nvim-tree").setup()
require("telescope").load_extension("fzf")
require("gitsigns").setup()
-- require("telescope").load_extension('cmdline')
require("neotest").setup({
  ft = { "go", "rust", "python" }, 
  adapters = {
    require("neotest-rust"),
    require("neotest-python"),
    require("neotest-go")
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
      vim.keymap.set('n', "<leader>td", function() require('neotest').run.run({ strategy = "dap" }) end, { desc= "[T]est [D]ebug"})
      rt.inlay_hints.enable()
    end,
  },
})

require("trouble").setup({
  use_diagnostic_signs = true
})

require('dap-go').setup()

vim.api.nvim_create_autocmd(
    {
        "BufNewFile",
        "BufRead",
    },
    {
        pattern = "*.go",
        callback = function()
          vim.keymap.set('n', "<leader>td", ":GoDebug --nearest <CR><CR>", { desc= "[T]est [D]ebug"})
        end
    }
)

vim.api.nvim_create_autocmd(

    {
        "BufNewFile",
        "BufRead",
    },
    {
        pattern = "*.py",
        callback = function()
          vim.keymap.set('n', "<leader>td", function() require('neotest').run.run({ strategy = "dap" }) end, { desc= "[T]est [D]ebug"})
        end
    }
)
local dap = require('dap')
dap.adapters.python = {
  type = 'executable';
  command = 'python';
  args = { '-m', 'debugpy.adapter' };
}


dap.configurations.python = {
  {
    -- The first three options are required by nvim-dap
    type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = 'launch';
    name = "Launch file";

    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

    program = "${file}"; -- This configuration will launch the current file if used.
    pythonPath = function()
      -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
      -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
      -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
      return os.getenv("VIRTUAL_ENV") .. "/bin/python" or '/usr/bin/env python'
    end;
  },
}

local status, saga = pcall(require, "lspsaga")
if (not status) then return end


local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<C-j>', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)
vim.keymap.set('n', 'gd', '<Cmd>Lspsaga finder<CR>', opts)
vim.keymap.set('i', '<C-k>', '<Cmd>Lspsaga signature_help<CR>', opts)
vim.keymap.set('n', 'gp', '<Cmd>Lspsaga preview_definition<CR>', opts)
vim.keymap.set('n', 'gr', '<Cmd>Lspsaga rename<CR>', opts)


-- Define a function to check that ollama is installed and working
local function get_condition()
    return package.loaded["ollama"] and require("ollama").status ~= nil
end


-- Define a function to check the status and return the corresponding icon
local function get_status_icon()
  local status = require("ollama").status()

  if status == "IDLE" then
    return "OLLAMA IDLE"
  elseif status == "WORKING" then
    return "OLLAMA BUSY"
  end
end

-- Load and configure 'lualine'
require("lualine").setup({
	sections = {
		lualine_a = {},
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { { "filename", path = 1 } },
		lualine_x = { get_status_icon, get_condition },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
})
