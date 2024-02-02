local config = function ()
  require('colorizer').setup()
end

return {
  "norcalli/nvim-colorizer.lua",
  lazy = false,
  config = config
}
