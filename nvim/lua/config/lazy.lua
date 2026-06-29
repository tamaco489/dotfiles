local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- lazy.nvim を初期化し、読み込むプラグインと動作設定を宣言する
require("lazy").setup({
  spec = {
    -- LazyVim 本体と組み込みプラグインを読み込む
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- Go: LSP (gopls)・フォーマット (goimports/gofumpt)・lint (golangci-lint)・デバッグ (delve) を自動セットアップ
    { import = "lazyvim.plugins.extras.lang.go" },
    -- TypeScript: LSP (vtsls)・ESLint・Prettier を自動セットアップ
    { import = "lazyvim.plugins.extras.lang.typescript" },
    -- JSON: スキーマ補完 (SchemaStore) を有効化
    { import = "lazyvim.plugins.extras.lang.json" },
    -- import/override with your plugins
    { import = "plugins" },
  },
  defaults = {
    -- デフォルトでは LazyVim 組み込みプラグインのみ遅延ロード。カスタムプラグインは起動時に即ロードされる
    -- true にすると全カスタムプラグインも遅延ロードになる (挙動を理解した上で変更する)
    lazy = false,
    -- semver 対応プラグインでも古いリリースタグが残っている場合があるため false 推奨
    version = false, -- 常に最新コミットを使用
    -- version = "*", -- semver 対応プラグインのみ最新安定版を使いたい場合はこちら
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  -- プラグインの更新を定期チェック
  checker = {
    enabled = true, -- 自動チェックを有効化
    notify = false, -- 更新通知は表示しない
  },
  performance = {
    rtp = {
      -- 不要な組み込みプラグインを無効化して起動を高速化
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
