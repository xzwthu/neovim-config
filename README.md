# neovim #
neovim 是vim的延续，可以通过lua语言管理插件，使用neovim，可以在终端中实现更好的代码编辑体验。
[toc]
## neovim 安装与配置
```
sudo apt update
sudo apt install neovim
```
安装好后，首先创建nvim的配置文件（这个配置文件和vim的'.vimrc'）一样：
```
mkdir ~/.config/nvim
nvim ~/.config/nvim/init.vim
```
一些简单的nvim配置：
```
let mapleader=","  "设置nvim快捷键为","
:map <tab> :bn<CR>  " 设置tab键为缓冲区切换键
:map! <C-S> <Esc>:w<CR> "Ctrl+s 为插入模式下的保存键
:map <C-H> :Bw<CR> "Ctrl+h 为关闭当前缓冲区文档 
```
## vim-plug 插件管理器
```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'\n
```
- 如果网络不好可以加proxychains前缀
## 各种插件
有了vim-plug插件管理器后，管理各种插件神器就会变得很容易。
在init.vim中写入：
```
call plug#begin('~/.vim/plugged')
call plug#end()
```
任何插件只需要写在上面两行之间就可以。例如写入可视化缩进插件indentLine：
`Plug 'Yggdroot/indentLine'`
退出init.vim后，进入新的nvim，在nvim命令行输入`:PlugInstall`就会自动安装indentLine插件，重启后就有了可视化插件的效果。
其他插件的安装也如此。下面推荐几个比较好用的插件。
- 自动补全[coc.nvim](https://github.com/neoclide/coc.nvim)
- 文件资源管理 [defx](https://github.com/Shougo/defx.nvim)
- 模糊匹配与搜索[fzf](https://github.com/junegunn/fzf.vim)
- 初始化面板 [dashboard](https://github.com/glepnir/dashboard-nvim) 
- vim缓冲区管理[vim-buffet](https://github.com/bagrat/vim-buffet) 
- 文件内部函数管理[tagbar](https://github.com/preservim/tagbar)
- 可视化缩进[indentLine](https://github.com/Yggdroot/indentLine)
- nvim中搜索神器[leaderF](https://github.com/Yggdroot/LeaderF)
