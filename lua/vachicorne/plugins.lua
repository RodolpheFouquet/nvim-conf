require("lazy").setup({
  {
    "navarasu/onedark.nvim",
    config = function()
        require("onedark").setup()
        require("onedark").load()
    end
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim"
    }
  },
  {
    "folke/trouble.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    }
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    opts = {
      options = {
        theme = "onedark",
        component_separators = "|",
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = {
          { "mode", separator = { left = "" }, right_padding = 2 },
        },
        lualine_b = { "filename", "branch" },
        lualine_c = { "fileformat" },
        lualine_x = {},
        lualine_y = { "filetype", "progress" },
        lualine_z = {
          { "location", separator = { right = "" }, left_padding = 2 },
        },
      },
    }
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lua" },
      { "hrsh7th/cmp-nvim-lua" },
      { "hrsh7th/cmp-nvim-lsp-signature-help" },
      { "hrsh7th/cmp-vsnip"},
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-buffer"},
      { "hrsh7th/vim-vsnip" },

    }
  },
  {
    "jonarrien/telescope-cmdline.nvim",
    name = "cmdline",
    opts = {},
    keys = {
      { ":", "<cmd>Telescope cmdline<cr>", desc = "Cmdline" }
    }
  },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate"  },
  { "nvim-treesitter/playground" },
  { "nvim-treesitter/nvim-treesitter-context" },
  { "mbbill/undotree" },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "neovim/nvim-lspconfig" },
  { "simrat39/rust-tools.nvim" },
  { "voldikss/vim-floaterm" },
  { "RRethy/vim-illuminate" },
  { "tpope/vim-surround" },
  { "lukas-reineke/indent-blankline.nvim" },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" }
  },
  {
    "numToStr/Comment.nvim",
    lazy = false,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {} -- this is equalent to setup({}) function
  },
  { "nvim-tree/nvim-tree.lua" }
})


