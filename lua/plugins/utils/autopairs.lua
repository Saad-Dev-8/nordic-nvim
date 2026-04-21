-- ~/.config/nvim/lua/plugins/utils/autopairs.lua

return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  dependencies = { "hrsh7th/nvim-cmp" },
  opts = {
    fast_wrap = {
      map          = "<M-e>",
      chars        = { "{", "[", "(", '"', "'" },
      pattern      = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
      offset       = 0,
      end_key      = "$",
      keys         = "qwertyuiopzxcvbnmasdfghjkl",
      check_comma  = true,
      highlight    = "PmenuSel",
      highlight_grey = "LineNr",
    },
  },
  config = function(_, opts)
    local autopairs     = require("nvim-autopairs")
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local cmp           = require("cmp")

    autopairs.setup(opts)

    -- 0.12-safe: on() still works but we guard in case cmp isn't ready
    if cmp.event then
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end
  end,
}
