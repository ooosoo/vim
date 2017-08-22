set nocompatible              " be iMproved, required
filetype off                  " required
" All of your Plugins must be added after the up line

"set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1 "打开中文乱码  
set enc=utf8 "存在菜单乱码，注释输出乱码  
"set fencs=utf8,gbk,gb2312,gb18030  


"vim的菜单乱码解决：  
"同样在 _vimrc文件里以上的中文设置后加上下列命令，  
source $VIMRUNTIME/delmenu.vim  
source $VIMRUNTIME/menu.vim  

"vim提示信息乱码的解决  
language messages zh_CN.utf-8 
"需要放在前面，要不然还是会乱码

set guifont=YouYuan:h12    "设置字体为Courier New,大小12号
winpos 800 0          " 设定窗口位置
set lines=40 columns=80


"定位到上次的光标
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Uncomment the following to have Vim jump to the last position when
" reopening a file  
if has("autocmd")
au BufReadPost * if line("`\"") > 1 && line("`\"") <= line("$") | exe "normal! g`\"" | endif
" for simplicity, "  au BufReadPost * exe "normal! g`\"", is Okay.
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"打开即关闭
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Go to last file(s) if invoked without arguments.
autocmd VimLeave * nested if (!isdirectory($HOME . "/.vim")) |
    \ call mkdir($HOME . "/.vim") |
    \ endif |
    \ execute "mksession! " . $HOME . "/.vim/Session.vim"

autocmd VimEnter * nested if argc() == 0 && filereadable($HOME . "/.vim/Session.vim") |
    \ execute "source " . $HOME . "/.vim/Session.vim"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""	
	
	
"自动补全括号引号等
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap { {<CR>}<Esc>O
autocmd Syntax html,vim inoremap < <lt>><Esc>i| inoremap > <c-r>=ClosePair('>')<CR>
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap } <c-r>=CloseBracket()<CR>
inoremap " <c-r>=QuoteDelim('"')<CR>
inoremap ' <c-r>=QuoteDelim("'")<CR>

function ClosePair(char)
 if getline('.')[col('.') - 1] == a:char
 return "\<Right>"
 else
 return a:char
 endif
endf

function CloseBracket()
 if match(getline(line('.') + 1), '\s*}') < 0
 return "\<CR>}"
 else
 return "\<Esc>j0f}a"
 endif
endf

function QuoteDelim(char)
 let line = getline('.')
 let col = col('.')
 if line[col - 2] == "\\"
 return a:char
 elseif line[col - 1] == a:char
 return "\<Right>"
 else
 return a:char.a:char."\<Esc>i"
 endif
endf

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"一些set
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"exec 'cd ' . fnameescape('C:\Datebase\Nutstore\Code\Python')
set fileencodings=ucs-bom,utf-8,utf-16,gbk,big5,gb18030,latin1  "中文
colorscheme monokai "默认配色
set autoread
set autowrite
set number
set expandtab
set tabstop=8
set shiftwidth=4
set softtabstop=4
set autoindent
:syntax on
"补全设置，不设也能用
let Tlist_Ctags_Cmd='/usr/bin/ctags'
filetype plugin indent on
filetype plugin on
set ofu=syntaxcomplete#Complete
highlight OverLength ctermbg=red ctermfg=white guibg=#592929 
match OverLength /\%81v.\+/


 
set nobackup      " 关闭自动备份功能,backup自动备份  

"当vim进行编辑时，如果命令错误，会发出一个响声，该设置去掉响声
set vb t_vb=


"设定文件浏览器目录为当前目录
set bsdir=buffer
set autochdir
"读文件时自动设定当前目录为刚读入文件所在的目录
autocmd BufReadPost * cd %:p:h


"不要生成swap文件，当buffer被丢弃的时候隐藏它
setlocal noswapfile 
set bufhidden=hide



" map <F5> :!python.exe % 
au BufRead *.py map <buffer> <F5> :w<CR>:! python % <CR>   "F5快捷运行python进行编译
