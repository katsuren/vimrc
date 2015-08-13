syntax enable
"強調表示(色付け)のON/OFF設定
syntax on

set number
set ruler
set list
set listchars=tab:>-,trail:-,nbsp:%,extends:>,precedes:<
set incsearch
set hlsearch
set nowrap
set showmatch
set nowrapscan
set ignorecase
set smartcase
set hidden
set history=2000
set autoindent
set expandtab
set tabstop=4
set shiftwidth=4
set helplang=en
set backspace=indent,eol,start
set ambiwidth=double

"UTF-8文字化け対応
set termencoding=utf-8
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,cp932
"新しい行を作ったときに高度な自動インデントを行う
set smartindent
"ステータス行の表示内容を設定する
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}G8%=%l,%c%V%8P
"vimのバックアップファイルとスワップファイル
set nobackup
set noswapfile
"MacVimやGVimを利用する際にIMEがモードの切替でオフとなる設定
set imdisable
"自動改行オフ
set tw=0
"ステータスラインを表示するウィンドウを設定する
"2:常にステータスラインを表示する
set laststatus=2

let loaded_matchparen = 1

" PHP の設定
" Baselibメソッドのハイライト
let php_baselib = 1
" <? を無効にする→ハイライト除外にする
let php_noShortTags = 1
" ] や ) の対応エラーをハイライト
let php_parent_error_close = 1
let php_parent_error_open = 1

" PHP の場合タブ入れとく
" autocmd BufNewFile,BufRead *.php set noexpandtab


nnoremap <silent> tt  :<C-u>tabe<CR>
nnoremap <C-p>  gT
nnoremap <C-n>  gt

nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR>

nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
nnoremap Q gq

nnoremap gs  :<C-u>%s///g<Left><Left><Left>
vnoremap gs  :s///g<Left><Left><Left>


"全角スペースを　で表示
highlight JpSpace cterm=underline ctermfg=Blue guifg=Blue
au BufRead,BufNew * match JpSpace /　/

" 挿入モードとノーマルモードでステータスラインの色を変更する
au InsertEnter * hi StatusLine guifg=DarkBlue guibg=DarkYellow gui=none ctermfg=Blue ctermbg=Yellow cterm=none
au InsertLeave * hi StatusLine guifg=Black guibg=White gui=none ctermfg=Black ctermbg=White cterm=none

" ヴィジュアルモードで選択したテキストをnで検索する(レジスタv使用)
vnoremap <silent> n "vy/\V<C-r>=substitute(escape(@v,'\/'),"\n",'\\n','g')<CR><CR>

" ファイルを開いたときに前回の編集箇所に移動
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif





""""""""""" NeoBundle設定  """""""""""
" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if has('vim_starting')
    if &compatible
        set nocompatible               " Be iMproved
    endif

    " Required:
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
" gitを使ったプラグインマネージャ 基本Vundleと一緒
NeoBundleFetch 'Shougo/neobundle.vim'


" Uniteコマンドによるフィルタ付き読み出し等
NeoBundle 'Shougo/unite.vim'
" Uniteコマンドでアウトラインを表示
NeoBundle 'h1mesuke/unite-outline'
" ,,でトグルでコメントアウト
NeoBundle 'scrooloose/nerdcommenter'
" 括弧囲みの編集操作
NeoBundle 'surround.vim'
"JSONのダブルクオーテーションが消えないように
NeoBundle 'elzr/vim-json'
let g:vim_json_syntax_conceal = 0
" JavaScriptのシンタクスハイライト
NeoBundle 'JavaScript-syntax'

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

filetype on
filetype indent on
filetype plugin on



""""""""""""""""""""""""""""""""""""""
"
"   以下プラグイン用設定
"
""""""""""""""""""""""""""""""""""""""

" Unite起動時にインサートモードで開始
let g:unite_enable_start_insert = 1
let g:unite_source_history_yank_enable =1

" Uniteの各種ショートカット設定
" バッファ一覧
nnoremap <silent> <C-u>b :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> <C-u>f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> <C-u>r :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> <C-u>m :<C-u>Unite file_mru<CR>
" 全部乗せ
nnoremap <silent> <C-u>a :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>

" Ctrl +  o でタグアウトラインを表示
nnoremap <C-o> :<C-u>Unite outline<CR>
nnoremap <C-l> :tabn<CR>
nnoremap <C-h> :tabp<CR>

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
  " 単語単位からパス単位で削除するように変更
  imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
  " ESCキーを2回押すと終了する
  nmap <silent><buffer> <ESC><ESC> q
  imap <silent><buffer> <ESC><ESC> <ESC>q
endfunction


" ,, でコメントアウトをトグル
let NERDSpaceDelims = 1
nmap ,, <Plug>NERDCommenterToggle
vmap ,, <Plug>NERDCommenterToggle
" コメントアウトが連続して入力されるのを禁止 :a!でも代用可
autocmd FileType * setlocal formatoptions-=ro





