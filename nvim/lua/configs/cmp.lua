local M = {}

function M.setup(opts)
  local cmp = require "cmp"
  local luasnip = require "luasnip"

  opts.completion = vim.tbl_deep_extend("force", opts.completion or {}, {
    autocomplete = { cmp.TriggerEvent.TextChanged },
    completeopt = "menu,menuone,noinsert",
  })

  opts.window = vim.tbl_deep_extend("force", opts.window or {}, {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  })

  opts.mapping = vim.tbl_deep_extend("force", opts.mapping or {}, {
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm { select = false },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  })

  opts.formatting = opts.formatting or {}
  opts.formatting.fields = { "kind", "abbr", "menu" }
  opts.formatting.format = function(entry, item)
    local icons = {
      Text = "󰉿",
      Method = "󰆧",
      Function = "󰊕",
      Constructor = "",
      Field = "󰜢",
      Variable = "󰀫",
      Class = "󰠱",
      Interface = "",
      Module = "",
      Property = "󰜢",
      Unit = "",
      Value = "󰎠",
      Enum = "",
      Keyword = "󰌋",
      Snippet = "",
      Color = "󰏘",
      File = "󰈙",
      Reference = "󰈇",
      Folder = "󰉋",
      EnumMember = "",
      Constant = "󰏿",
      Struct = "󰙅",
      Event = "",
      Operator = "󰆕",
      TypeParameter = "󰅲",
    }

    item.kind = string.format("%s %s", icons[item.kind] or "󰋙", item.kind)
    item.menu = "  [" .. entry.source.name .. "]"
    return item
  end

  return opts
end

return M
