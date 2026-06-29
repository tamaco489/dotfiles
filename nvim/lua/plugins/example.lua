-- このファイルはサンプル設定のため実際には読み込まれない。実用する場合は最初の行を削除する
-- stylua: ignore
if true then return {} end

-- "plugins" ディレクトリ配下の全ファイルは lazy.nvim が自動的に読み込む
--
-- プラグインファイルでできること:
-- * 新しいプラグインの追加
-- * LazyVim 組み込みプラグインの有効化・無効化
-- * LazyVim 組み込みプラグインの設定上書き
return {
  -- gruvbox を追加
  { "ellisonleao/gruvbox.nvim" },

  -- LazyVim のカラースキームを gruvbox に変更
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },

  -- trouble.nvim の設定を変更
  {
    "folke/trouble.nvim",
    -- opts は親スペックの設定にマージされる
    opts = { use_diagnostic_signs = true },
  },

  -- trouble.nvim を無効化
  { "folke/trouble.nvim", enabled = false },

  -- nvim-cmp に cmp-emoji を追加
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
  },

  -- telescope のオプション変更とプラグインファイル検索キーマップを追加
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- プラグインファイルを開くキーマップを追加
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
    },
    -- デフォルトオプションを変更
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },

  -- nvim-lspconfig に pyright を追加
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright は mason で自動インストールされ lspconfig で読み込まれる
        pyright = {},
      },
    },
  },

  -- lspconfig の代わりに typescript.nvim で tsserver を設定
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      init = function()
        require("lazyvim.util").lsp.on_attach(function(_, buffer)
          -- stylua: ignore
          vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
          vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
        end)
      end,
    },
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- tsserver は mason で自動インストールされ lspconfig で読み込まれる
        tsserver = {},
      },
      -- LSP サーバーの追加セットアップをここで行える
      -- true を返すと lspconfig によるセットアップをスキップできる
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- typescript.nvim でセットアップする例
        tsserver = function(_, opts)
          require("typescript").setup({ server = opts })
          return true
        end,
        -- * を指定すると全サーバーのフォールバック関数として使える
        -- ["*"] = function(server, opts) end,
      },
    },
  },

  -- TypeScript は LazyVim の extra を使うと lspconfig / treesitter / mason / typescript.nvim を一括設定できる
  { import = "lazyvim.plugins.extras.lang.typescript" },

  -- treesitter パーサーを追加インストール
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    },
  },

  -- vim.tbl_deep_extend はテーブルのみマージ対象でリストは上書きになるため
  -- デフォルト設定を拡張したい場合は以下のように opts 関数を使う
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- tsx と TypeScript パーサーを追加
      vim.list_extend(opts.ensure_installed, {
        "tsx",
        "typescript",
      })
    end,
  },

  -- opts 関数でデフォルト設定をすべて上書きすることもできる
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, {
        function()
          return "😄"
        end,
      })
    end,
  },

  -- opts 関数で新しい設定を返してデフォルトをすべて置き換える例
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      return {
        --[[カスタム lualine 設定をここに追加]]
      }
    end,
  },

  -- alpha の代わりに mini.starter を使用
  { import = "lazyvim.plugins.extras.ui.mini-starter" },

  -- jsonls と schemastore を追加し json / json5 / jsonc の treesitter を設定
  { import = "lazyvim.plugins.extras.lang.json" },

  -- mason で追加インストールするツール
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
      },
    },
  },
}
