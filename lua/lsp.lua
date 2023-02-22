-- Mason
require('mason').setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

-- LSP
require('mason-lspconfig').setup({
    -- A list of servers to automatically install if they're not already installed
    ensure_installed = { 'pylsp', 'gopls', 'lua_ls', 'rust_analyzer' },
})

-- Python
require('lspconfig').pyright.setup{}

-- Go
require('go').setup()
local cfg = require'go.lsp'.config() -- config() return the go.nvim gopls setup
require('lspconfig').gopls.setup(cfg)

-- Rust
local rt = require("rust-tools")
local extension_path = vim.env.HOME .. '/.vscode/extensions/vadimcn.vscode-lldb-1.8.1/'
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.dylib'

rt.setup({
    tools = {
        hover_actions = {
            auto_focus = true
        }
    },
    server = {
        on_attach = function(_, bufnr)
        -- Hover actions
        vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
        -- Code action groups
        vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
        
        -- Runnables
        vim.keymap.set("n", "<Leader>rr", rt.runnables.runnables)
       
        -- Hover
        vim.keymap.set("n", "<Leader>h", rt.hover_actions.hover_actions)

        vim.keymap.set("n", "<Leader>mj", "<cmd>RustMoveItemDown<CR>")
        vim.keymap.set("n", "<Leader>mk", "<cmd>RustMoveItemUp<CR>")
        
        
        vim.keymap.set("n", "<Leader>b", "<cmd>lua require'dap'.toggle_breakpoint()<CR>")
        vim.keymap.set("n", "<Leader>c", "<cmd>lua require'dap'.continue()<CR>")
        vim.keymap.set("n", "<Leader>ss", "<cmd>lua require'dap'.step_over()<CR>")
        vim.keymap.set("n", "<Leader>sd", "<cmd>lua require'dap'.step_into()<CR>")

        end,
    },
    dap = {
        adapter = require('rust-tools.dap').get_codelldb_adapter(
            codelldb_path, liblldb_path)
    }
})

-- enable rust hints
rt.inlay_hints.enable()


-- Debugger 
require("dapui").setup()
require("neodev").setup({
    library = { plugins = { "nvim-dap-ui" }, types = true },
})

local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

