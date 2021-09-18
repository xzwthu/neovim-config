" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
let mapleader=","
:map <tab> :bn<CR>  
" 设置tab键为缓冲区切换键
:map! <C-S> <Esc>:w<CR> 
"Ctrl+s 为插入模式下的保存键
:map <C-H> :Bw<CR> 
"Ctrl+h 为关闭当前缓冲区文档 

call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
"
"""""""""""""""""""""""""""""""""""""
"indentLine
""""""""""""""""""""""""""""""""""""
Plug 'Yggdroot/indentLine'
let g:indent_guides_guide_size            = 1  " 指定对齐线的尺寸
let g:indent_guides_start_level           = 2  " 从第二层开始可视化显示缩进
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"treesitter语法高亮
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" LeaderF 当前文档搜索
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
  """"""""""""""""""""""""""""""
  "Leaderf settings
  """"""""""""""""""""""""""""""
  "文件搜索
  nnoremap <silent> <Leader>f :Leaderf file<CR>

  "历史打开过的文件
  nnoremap <silent> <Leader>m :Leaderf mru<CR>

  "Buffer
  nnoremap <silent> <Leader>b :Leaderf buffer<CR>

  "函数搜索（仅当前文件里）
  nnoremap <silent> <Leader>F :Leaderf function<CR>

  "模糊搜索，很强大的功能，迅速秒搜
  nnoremap <silent> <Leader>rg :Leaderf rg<CR>

""""""""""""""""""""""""""""""""""""""""""""""
"airline状态配色插件
""""""""""""""""""""""""""""""""""""""""
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"""""""
"tagbar
"""""
Plug 'majutsushi/tagbar'
let g:tagbar_width=30
"将tagbar的开关按键设置为 F4
nnoremap <silent> <F4> :TagbarToggle<CR>  
""""""""
" vim-buffet
"""""""
Plug 'bagrat/vim-buffet'
nmap <leader>1 <Plug>BuffetSwitch(1)
nmap <leader>2 <Plug>BuffetSwitch(2)
nmap <leader>3 <Plug>BuffetSwitch(3)
nmap <leader>4 <Plug>BuffetSwitch(4)
nmap <leader>5 <Plug>BuffetSwitch(5)
nmap <leader>6 <Plug>BuffetSwitch(6)
nmap <leader>7 <Plug>BuffetSwitch(7)
nmap <leader>8 <Plug>BuffetSwitch(8)
nmap <leader>9 <Plug>BuffetSwitch(9)
nmap <leader>0 <Plug>BuffetSwitch(10)



""""""""
" fzf 
""""""""
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'glepnir/dashboard-nvim'
let g:mapleader="\<Space>"
let g:dashboard_default_executive ='fzf'


"""""""""""""""""""""""""""""""""
" Defx
""""""""""""""""""""
" file directory management
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
nmap <silent> ff :Defx  -search=`expand('%:p')` -toggle <cr>

    "打开vim自动打开defx
    func! ArgFunc() abort
        let s:arg = argv(0)
        if isdirectory(s:arg)
            return s:arg
        else
            return fnamemodify(s:arg, ':h')
        endif
    endfunc
    autocmd VimEnter * Defx `ArgFunc()` -no-focus -search=`expand('%:p')`

    " Exit Vim if defxTree is the only window left.
    autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:defx') |
    \ quit | endif

    " 在打开多个tab的情况下，当前tab里只有一个buffer和nerd树，当关闭buffer时，自动关闭当前标签页的nerd树
    autocmd BufEnter * if tabpagenr('$') > 1 && winnr('$') == 1 && exists('b:defx') |
    \ tabclose | endif

    " 在新tab页打开文件
    func! MyT(context) abort
        if isdirectory(get(a:context.targets, 0)) == 0
            call defx#call_action('drop', 'tabe')
        endif
    endfunc

    " 给cd快捷键写的
    func! MyCD(context) abort
        if isdirectory(get(a:context.targets, 0))
            execute 'cd' . get(a:context.targets, 0)
        else
            execute 'cd' . fnamemodify(defx#get_candidate().action__path, ':h')
        endif
    endfunc

    " 给 ter 快捷键写的
    func! MyTER(context) abort
        if isdirectory(get(a:context.targets, 0))
            execute '!xfce4-terminal --working-directory=' . get(a:context.targets, 0)
        else
            execute '!xfce4-terminal --working-directory=' . fnamemodify(defx#get_candidate().action__path, ':h')
        endif
    endfunc
autocmd FileType defx call s:defx_mappings()

function! s:defx_mappings() abort
	nnoremap <silent><buffer><expr> <CR>     defx#do_action('drop')
        nnoremap <silent><buffer><expr> t        defx#do_action('call', 'MyT')
        nnoremap <silent><buffer><expr> yy       defx#do_action('yank_path')
        nnoremap <silent><buffer><expr> dd       defx#do_action('remove_trash')
        nnoremap <silent><buffer><expr> cc        defx#do_action('copy')
        nnoremap <silent><buffer><expr> mm        defx#do_action('move')
        nnoremap <silent><buffer><expr> pp        defx#do_action('paste')
        nnoremap <silent><buffer><expr> N        defx#do_action('new_file')
        nnoremap <silent><buffer><expr> M        defx#do_action('new_multiple_files')
        nnoremap <silent><buffer><expr> R        defx#do_action('rename')
        nnoremap <silent><buffer><expr> j        line('.') == line('$') ? 'gg' : 'j'
        nnoremap <silent><buffer><expr> k        line('.') == 1 ? 'G' : 'k'
        nnoremap <silent><buffer><expr> h    
                    \ defx#is_opened_tree() ? 
                    \ defx#do_action('close_tree', defx#get_candidate().action__path) : 
                    \ defx#do_action('search',  fnamemodify(defx#get_candidate().action__path, ':h'))
        nnoremap <silent><buffer><expr> l        defx#do_action('open_tree')
	nnoremap <silent><buffer><expr> o        defx#do_action('open_directory')
        nnoremap <silent><buffer><expr> u        defx#do_action('cd', ['..'])
        nnoremap <silent><buffer><expr> E        defx#do_action('open', 'vsplit')
        nnoremap <silent><buffer><expr> P        defx#do_action('preview')
        "nnoremap <silent><buffer><expr> d        defx#do_action('new_directory')
        nnoremap <silent><buffer><expr> C        defx#do_action('toggle_columns',  'mark:indent:icon:filename:type:size:time')
        nnoremap <silent><buffer><expr> S        defx#do_action('toggle_sort', 'time')
        nnoremap <silent><buffer><expr> !        defx#do_action('execute_command')
        nnoremap <silent><buffer><expr> x        defx#do_action('execute_system')
        nnoremap <silent><buffer><expr> cd       defx#do_action('call', 'MyCD')
        nnoremap <silent><buffer><expr> ~        defx#do_action('cd')
        nnoremap <silent><buffer><expr> ter      defx#do_action('call', 'MyTER')
        nnoremap <silent><buffer><expr> .        defx#do_action('toggle_ignored_files')
        nnoremap <silent><buffer><expr> q        defx#do_action('quit')
        nnoremap <silent><buffer><expr> <Space>  defx#do_action('toggle_select') . 'j'
        nnoremap <silent><buffer><expr> *        defx#do_action('toggle_select_all')
        nnoremap <silent><buffer><expr> m        defx#do_action('clear_select_all')
        nnoremap <silent><buffer><expr> r        defx#do_action('redraw')
        nnoremap <silent><buffer><expr> pr       defx#do_action('print')
        nnoremap <silent><buffer><expr> >        defx#do_action('resize',  defx#get_context().winwidth - 10)
        nnoremap <silent><buffer><expr> <        defx#do_action('resize',  defx#get_context().winwidth + 10)
	nnoremap <silent><buffer><expr> <2-LeftMouse>

endfunction


" Defx git
Plug 'kristijanhusak/defx-git'
let g:defx_git#indicators = {
  \ 'Modified'  : '✹',
  \ 'Staged'    : '✚',
  \ 'Untracked' : '✭',
  \ 'Renamed'   : '➜',
  \ 'Unmerged'  : '═',
  \ 'Ignored'   : '☒',
  \ 'Deleted'   : '✖',
  \ 'Unknown'   : '?'
  \ }
let g:defx_git#column_length = 0
hi def link Defx_filename_directory NERDTreeDirSlash
hi def link Defx_git_Modified Special
hi def link Defx_git_Staged Function
hi def link Defx_git_Renamed Title
hi def link Defx_git_Unmerged Label
hi def link Defx_git_Untracked Tag
hi def link Defx_git_Ignored Comment

" Defx icons
" Requires nerd-font, install at https://github.com/ryanoasis/nerd-fonts or
" brew cask install font-hack-nerd-font
" Then set non-ascii font to Driod sans mono for powerline in iTerm2
Plug 'kristijanhusak/defx-icons'
" disbale syntax highlighting to prevent performence issue
let g:defx_icons_enable_syntax_highlight = 1



" autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" Initialize plugin system
call plug#end()
call defx#custom#option('_', {
      \ 'winwidth': 30,
      \ 'split': 'vertical',
      \ 'direction': 'topleft',
      \ 'show_ignored_files': 0,
      \ 'buffer_name': '',
      \ 'toggle': 1,
      \ 'resume': 1
      \ })

