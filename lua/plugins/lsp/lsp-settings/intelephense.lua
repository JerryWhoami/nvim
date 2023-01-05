return {
  root_dir = function(fname)
    return vim.loop.cwd()
  end,
  settings = {
    intelephense = {
      references = {
        exclude = {},
      },
      files = {
        exclude = {
          "**/.git/**",
          "**/.svn/**",
          "**/.hg/**",
          "**/CVS/**",
          "**/.DS_Store/**",
          "**/node_modules/**",
          "**/bower_components/**",
          "**/.history/**",
        },
      },
    },
  },
}
