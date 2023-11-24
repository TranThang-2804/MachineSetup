return {
  "nvimdev/dashboard-nvim",
  dependancy = "nvim-telescope/telescope.nvim",
  priority = 1000,
  opts = function()
    local logo = [[
████████╗ ██████╗ ███╗   ███╗███╗   ███╗██╗   ██╗
╚══██╔══╝██╔═══██╗████╗ ████║████╗ ████║╚██╗ ██╔╝
  ██║   ██║   ██║██╔████╔██║██╔████╔██║ ╚████╔╝
  ██║   ██║   ██║██║╚██╔╝██║██║╚██╔╝██║  ╚██╔╝
  ██║   ╚██████╔╝██║ ╚═╝ ██║██║ ╚═╝ ██║   ██║
  ╚═╝    ╚═════╝ ╚═╝     ╚═╝╚═╝     ╚═╝   ╚═╝
    ]]

    logo = string.rep("\n", 8) .. logo .. "\n\n"

    require("telescope")

    local opts = {
      theme = "doom",
      hide = {
        -- this is taken care of by lualine
        -- enabling this messes up the actual laststatus setting after loading a file
        statusline = false,
      },
      config = {
        header = vim.split(logo, "\n"),
        -- stylua: ignore
        center = {
          { action = "Neotree toggle=true position=float", desc = " Open Neotree", icon = " ", key = "o" },
          { action = "Telescope find_files", desc = " Find file", icon = " ", key = "f" },
          { action = "Telescope oldfiles", desc = " Recent files", icon = " ", key = "r" },
          { action = "Telescope live_grep", desc = " Find text", icon = " ", key = "g" },
          { action = "qa", desc = " Quit", icon = " ", key = "q" },
        },
        footer = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
        end,
      },
    }

    for _, button in ipairs(opts.config.center) do
      button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
      button.key_format = "  %s"
    end

    -- close Lazy and re-open when the dashboard is ready
    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        pattern = "DashboardLoaded",
        callback = function()
          require("lazy").show()
        end,
      })
    end

    return opts
  end,
  init = function()
    if vim.fn.argc(-1) == 1 then
      local stat = vim.loop.fs_stat(vim.fn.argv(0))
      if stat and stat.type == "directory" then
        require("dashboard")
        vim.cmd("Dashboard")
      end
    end
  end,
}