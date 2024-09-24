local config = function ()
  require('virt-column').setup {}
end

return {
  "lukas-reineke/virt-column.nvim",
  lazy = false,
  config = config
}

