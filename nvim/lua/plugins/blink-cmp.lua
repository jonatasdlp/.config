return {
  "saghen/blink.cmp",
  dependencies = {
    "rafamadriz/friendly-snippets",
    "echasnovski/mini.icons",
    "onsails/lspkind-nvim",
  },
  event = "VeryLazy",
  version = "*",
  opts = {
    enabled = function()
      return not vim.tbl_contains({ "oil" }, vim.bo.filetype)
    end,
    keymap = {
      preset = "enter",
      ["<C-h>"] = {
        function(cmp)
          cmp.show_documentation()
        end,
      },
      ["<tab>"] = {},
    },
    signature = { enabled = false },
    appearance = {
      -- use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },

    cmdline = {
      keymap = {
        ["<Tab>"] = { "show", "select_next" },
        ["<S-Tab>"] = { "select_prev" },
        ["<cr>"] = { "select_and_accept", "fallback" },
        ["<space>"] = { "select_and_accept", "fallback" },
        ["<right>"] = { "select_and_accept", "fallback" },
        ["<down>"] = { "select_next", "fallback" },
        ["<up>"] = { "select_prev", "fallback" },
        ["<esc>"] = {
          "cancel",
          function()
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-c>", true, false, true), "n", true)
          end,
        },
      },

      sources = function()
        local type = vim.fn.getcmdtype()
        -- Search forward and backward
        if type == "/" or type == "?" then
          return {}
        end
        -- Commands
        if type == ":" or type == "@" then
          return { "cmdline", "path" }
        end
        return {}
      end,
      completion = { ghost_text = { enabled = false } },
    },

    completion = {
      trigger = {
        show_on_trigger_character = true,
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = {
          border = "rounded",
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
        },
      },
      list = {
        selection = {
          auto_insert = false,
        },
      },
      menu = {
        border = "rounded",
        draw = {
          gap = 2,
          components = {
            kind_icon = {
              ellipsis = false,
              highlight = function(ctx)
                local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                return hl
              end,
              text = function(ctx)
                local icon = require("lspkind").symbolic(ctx.kind, { mode = "symbol" })
                return icon .. ctx.icon_gap
              end,
            },
          },
        },
        winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
      },
    },
  },
  opts_extend = { "sources.default" },
}
