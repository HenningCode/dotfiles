return {
  "stevearc/oil.nvim",
  config = function()
    local oil = require("oil")
    oil.setup({
            delete_to_trash = true,
            skip_confim_for_simple_edits = true
        })
    vim.keymap.set("n", "-", oil.toggle_float, {desc="Open Oil.nvim"})
  end,
}
