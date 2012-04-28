# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh
export SCRIPTS=$HOME/scripts
# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="clean"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh
source $SCRIPTS/aliases 
source $SCRIPTS/common_zshrc 
# Customize to your needs...
export PATH=/home/pradeep/mysql/bin:/home/pradeep/sourcery/bin:/home/pradeep/CodeSourcery/Sourcery_G++_Lite/bin:/home/pradeep/.cabal/bin:/home/pradeep/ringojs/bin:/home/pradeep/flex/bin:/home/pradeep/.gem/ruby/1.8/bin:/home/pradeep/sourcery/bin:/home/pradeep/CodeSourcery/Sourcery_G++_Lite/bin:/home/pradeep/.cabal/bin:/home/pradeep/ringojs/bin:/home/pradeep/flex/bin:/home/pradeep/.gem/ruby/1.8/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games/ 
export PATH=$HOME/go/bin:$PATH
export PATH="$PATH:$HOME/src/git-achievements"
export PATH="$PATH:$HOME/scala/bin"
export ALTERNATE_EDITOR=""
export PATH="$PATH:$HOME/play/bin"
export PATH="$PATH:$HOME/scripts"
export PERLLIB=$PATH

## Lua
export LUA_PATH="./?.lua;/usr/local/share/lua/5.1/?.lua;  /usr/share/lua/5.1/?/?.lua;$HOME/.luarocks/share/lua/5.1/?.lua; $HOME/.luarocks/share/lua/5.1/?/?.lua; $HOME/local/share/lua/5.1/?/?.lua"
export LUA_CPATH="./?.so;/usr/local/lib/lua/5.1/?.so;/usr/lib/lua/5.1/?/?.so;   $HOME/.luarocks/share/lua/5.1/?/?.so;$HOME/.luarocks/lib/lua/5.1/?.so;$HOME/.luarocks/lib/lua/5.1/?/?.so; $HOME/local/lib/?/?.so"
export PATH=$HOME/.luarocks/bin:$PATH
export PATH=$HOME/local/bin:$PATH

## GO
export GOROOT=$HOME/go
export GOARCH=amd64
## PyPy
export PATH=/opt/pypy/bin:$PATH

export DEBEMAIL="pradeep@btbytes.com"
export DEBFULLNAME="Pradeep Gowda"
export DEBEMAIL DEBFULLNAME 
export POCO_BASE=$HOME/src/poco

setxkbmap us 

export TEXMFHOME=$HOME/texmf
export TEXINPUTS=$HOME/texmf/tex: # search path for style files 
export BSTINPUTS=$HOME/texmf/tex: # search path for .bst files 
export BIBINPUTS=$HOME/texmf/bibtex: # search path for .bib files 
