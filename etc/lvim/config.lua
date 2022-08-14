lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.builtin.terminal.active = true
lvim.builtin.dap.active = true
lvim.builtin.bufferline.options.separator_style = "padded_slant"
lvim.colorscheme = "catppuccin"
vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha

-- vim options
vim.o.guifont = "JetBrainsMono Nerd Font:h13"
vim.o.cmdheight = 1
vim.opt.list = true
vim.opt.colorcolumn = "80" -- fixes indentline for now
vim.opt.shiftwidth = 4 -- the number of spaces inserted for each indentation
vim.opt.showtabline = 2 -- always show tabs
vim.opt.tabstop = 4 -- insert 2 spaces for a tab
vim.opt.relativenumber = true
vim.opt.numberwidth = 2


-- mappings
lvim.keys.normal_mode["<S-l>"] = false
lvim.keys.normal_mode["<S-h>"] = false
vim.api.nvim_set_keymap('n', ';', ':', { noremap = true })
vim.api.nvim_set_keymap('n', ':', ';', { noremap = true })

-- swith buffer
vim.api.nvim_set_keymap('n', '<bs>', '<c-^>', { noremap = true })
vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = true })
vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = true })
vim.api.nvim_set_keymap('n', '<Tab>', ':bnext<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<S-Tab>', ':bprevious<CR>', { noremap = true })

-- Make 0 go to the first character rather than the beginning
-- of the line. When we're programming, we're almost always
-- interested in working with text rather than empty space. If
-- you want the traditional beginning of line, use ^
vim.api.nvim_set_keymap('n', '0', '^', { noremap = true })
vim.api.nvim_set_keymap('n', '^', '0', { noremap = true })

-- These are very similar keys. Typing 'a will jump to the line in the current
-- file marked with ma. However, `a will jump to the line and column marked
-- with ma.  It’s more useful in any case I can imagine, but it’s located way
-- off in the corner of the keyboard. The best way to handle this is just to
-- swap them: http://items.sjbach.com/319/configuring-vim-right
vim.api.nvim_set_keymap('n', "'", '`', { noremap = true })
vim.api.nvim_set_keymap('n', '`', "'", { noremap = true })


-- Source this line, place your cursor on ), press zl and you'll understand
--    println()foo
vim.api.nvim_set_keymap('n', 'zl', '@z=@"<cr>x$p:let @"=@z<cr>', { noremap = true })


-- statusline
lvim.builtin.lualine = {
    active = true,
    options = {
        theme = "catppuccin",
        component_separators = '|',
        section_separators = { left = '', right = '' },
    },
    sections = {
        lualine_a = {
            { 'mode', separator = { left = '' }, right_padding = 2, icon = "" },
        },
        lualine_b = { 'filename', { 'branch', icon = '' } },
        lualine_c = { { 'diff', symbols = { added = ' ', modified = '柳', removed = ' ' }, } },

        lualine_x = { 'diagnostics' },
        lualine_y = { 'filetype' },
        lualine_z = {
            { 'progress', icon = "", separator = { right = '' } },
        },
    },
    inactive_sections = {
        lualine_a = { 'filename' },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { 'location' },
    },
    tabline = {},
    extensions = {},
    style = "lvim"
}

vim.api.nvim_create_autocmd("BufWinEnter", {
    pattern = { "*.ts" },
    command = "setlocal tabstop=2 shiftwidth=2",
})

lvim.plugins = {
    { "arcticicestudio/nord-vim" },
    {
        "catppuccin/nvim",
        as = "catppuccin"
    },
    {
        "folke/trouble.nvim",
    },
    {
        "ray-x/lsp_signature.nvim",
        event = "BufRead",
        config = function()
            require "lsp_signature".on_attach()
        end
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufRead",
        setup = function()
            vim.opt.termguicolors = true
            vim.g.indent_blankline_filetype_exclude = { "help", "terminal", "dashboard" }
            vim.g.indent_blankline_buftype_exclude = { "terminal" }
        end
    },
    {
        "tpope/vim-surround",
        keys = { "c", "d", "y" }
        -- make sure to change the value of `timeoutlen` if it's not triggering correctly, see https://github.com/tpope/vim-surround/issues/117
        -- setup = function()
        --  vim.o.timeoutlen = 500
        -- end
    },

    {
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        ft = "markdown",
        config = function()
            vim.g.mkdp_auto_start = 1
        end,
    },
}


lvim.builtin.which_key.mappings["t"] = {
    name = "Diagnostics",
    t = { "<cmd>TroubleToggle<cr>", "trouble" },
    w = { "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>", "workspace" },
    d = { "<cmd>TroubleToggle lsp_document_diagnostics<cr>", "document" },
    q = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" },
    l = { "<cmd>TroubleToggle loclist<cr>", "loclist" },
    r = { "<cmd>TroubleToggle lsp_references<cr>", "references" },
}

lvim.builtin.which_key.mappings["T"] = {
    name = "ToggleTerm",
    t = { "<cmd>ToggleTerm<cr>", "Terminal" },
}


local TelescopePrompt = {
    TelescopePromptNormal = {
        bg = '#2d3149',
    },
    TelescopePromptBorder = {
        bg = '#2d3149',
    },
    TelescopePromptTitle = {
        fg = '#2d3149',
        bg = '#2d3149',
    },
    TelescopePreviewTitle = {
        fg = '#1F2335',
        bg = '#1F2335',
    },
    TelescopeResultsTitle = {
        fg = '#1F2335',
        bg = '#1F2335',
    },
}
for hl, col in pairs(TelescopePrompt) do
    vim.api.nvim_set_hl(0, hl, col)
end
