-- LazyVim のデフォルトキーマップが先に読み込まれるため、ここでは追加・上書きのみ行う
-- デフォルト値の確認: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local map = vim.keymap.set

-- jj で Insert モードを抜ける
map("i", "jj", "<Esc>", { desc = "Insert モードを終了" })

-- ウィンドウ分割
map("n", "<leader>|", "<cmd>vsplit<cr>", { desc = "垂直分割" })
map("n", "<leader>-", "<cmd>split<cr>", { desc = "水平分割" })

-- バッファ移動
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "前のバッファへ" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "次のバッファへ" })

-- 選択範囲のインデントを維持したまま繰り返す
map("v", "<", "<gv", { desc = "インデントを下げる" })
map("v", ">", ">gv", { desc = "インデントを上げる" })

-- 検索ハイライトをクリア
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "検索ハイライトを消す" })
