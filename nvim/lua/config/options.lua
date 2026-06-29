-- LazyVim のデフォルト設定が先に読み込まれるため、ここでは追加・上書きのみ行う
-- デフォルト値の確認: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

local opt = vim.opt

-- 行番号
opt.number = true         -- 行番号を表示
opt.relativenumber = true -- カーソル行からの相対行番号を表示

-- インデント
opt.tabstop = 2      -- タブ幅を 2 スペースとして表示
opt.shiftwidth = 2   -- 自動インデントのスペース数
opt.expandtab = true -- タブをスペースに展開

-- 検索
opt.ignorecase = true -- 検索時に大文字・小文字を区別しない
opt.smartcase = true  -- 大文字を含む検索語の場合は区別する

-- 表示
opt.cursorline = true    -- カーソル行をハイライト
opt.colorcolumn = "120"  -- 120文字目にガイド線を表示
opt.scrolloff = 8        -- カーソル上下に常に 8 行の余白を確保
opt.wrap = false         -- 長い行を折り返さない

-- クリップボード
opt.clipboard = "unnamedplus" -- システムクリップボードと共有

-- ファイル
opt.swapfile = false -- スワップファイルを作成しない
opt.undofile = true  -- 永続 undo を有効化 (再起動後も undo できる)
