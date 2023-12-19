local config = function()

  local indent = require("ibl")
  local column = require("virt-column")

  indent.setup()
  column.setup {
    char = '▕',
    priority = 10,
  }
end

return {
  "lukas-reineke/indent-blankline.nvim",
  dependencies = {"lukas-reineke/virt-column.nvim"},
  lazy = false,
  config = config,
}
