return { {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = false },
    explorer = { enabled = false },
    indent = { enabled = false },
    input = { enabled = true },
    picker = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = false },
    scope = { enabled = true },
    scroll = {
      enabled = true,
      animate = {
        duration = { step = 15, total = 150 },
        easing = "inOutQuad",
      },
      animate_repeat = {
        delay = 100,
        duration = { step = 5, total = 50 },
        easing = "inOutQuad",
      },
    },
    statuscolumn = { enabled = true },
    words = { enabled = false },
  },
},
}
