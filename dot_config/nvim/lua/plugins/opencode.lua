return {
  "https://github.com/sudo-tee/opencode.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "MeanderingProgrammer/render-markdown.nvim",
    "saghen/blink.cmp",
  },
  opts = {
    server = {
      url = "http://localhost",
      port = 4096,
      password = "local_password",
    },
  },
}
