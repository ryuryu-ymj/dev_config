-- バックアップを取らない
vim.opt.backup = false
vim.opt.writebackup = false
-- swapファイルの作成およびCursorHoldの判定時間
vim.opt.updatetime = 1000
-- マウスの操作を全部有効化
vim.opt.mouse = 'a'
-- ウィンドウ幅を超えた行をラップしない
vim.opt.wrap = false
-- 行をまたいで移動
vim.opt.whichwrap = 'b,s,h,l,<,>,[,],~'
-- 矩形選択で文字がなくても右に進める
vim.opt.virtualedit = 'block'
-- ヤンクしたときにクリップボードに保存
vim.opt.clipboard:append('unnamedplus')
-- vim.cmd [[ let g:clipboard = {
--           \   'name': 'myClipboard',
--           \   'copy': {
--           \      '+': ['tmux', 'load-buffer', '-'],
--           \      '*': ['tmux', 'load-buffer', '-'],
--           \    },
--           \   'paste': {
--           \      '+': ['tmux', 'save-buffer', '-'],
--           \      '*': ['tmux', 'save-buffer', '-'],
--           \   },
--           \   'cache_enabled': 1,
--           \ } ]]

-- 行番号を表示
vim.opt.number = true
-- 行番号を相対表示に
vim.opt.relativenumber = true
-- 編集行を強調
vim.opt.cursorline = true
-- 対応する括弧を表示
vim.opt.showmatch.matchtime = 1
-- 行末のスペースを可視化
vim.opt.list = true
vim.opt.listchars = 'tab:^\\ ,trail:~'
-- カラースキームをダークモードに
vim.opt.background = 'dark'
-- True Colorを有効に
vim.opt.termguicolors = true
-- モードを表示しない
vim.opt.showmode = false

-- 入力モードでTabキー押下時に半角スペースを挿入
vim.opt.expandtab = true
-- 自動挿入されるインデント幅を指定
vim.opt.shiftwidth = 4
-- タブ文字を4文字文の幅で表示
vim.opt.tabstop = 4
-- タブキーで指定した数，空白が挿入される
vim.opt.softtabstop = 4

-- 置換時に入力途中で検索開始
vim.opt.inccommand = 'nosplit'
-- 検索結果をハイライト
vim.opt.hlsearch = true
-- スマートケース
vim.opt.ignorecase = true
vim.opt.smartcase = true
