return {
    {
        "hrsh7th/nvim-cmp",
        version = false,
        event = "InsertEnter",
	dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
        },
    },
    { "hrsh7th/cmp-nvim-lsp", lazy = true },
    { "hrsh7th/cmp-path", lazy = true },
    { "hrsh7th/cmp-buffer", lazy = true },
    config = function()
        local cmp = require('cmp')
        local opts = {
            -- Where to get completion results from
            sources = cmp.config.sources {
                { name = "nvim_lsp" },
                { name = "buffer"},
                { name = "path" },
            },
            -- Make 'enter' key select the completion
            mapping = cmp.mapping.preset.insert({
                ["<CR>"] = cmp.mapping.confirm({ select = true })
            }),
        }
        cmp.setup(opts)
    end,
}
