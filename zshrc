# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="robbyrussell"

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


export PATH=/Users/pradeep/rock/bin:/Users/pradeep/src/elib1/bin:/Users/pradeep/android-sdk:/Users/pradeep/narwhal/bin:/Users/pradeep/mongodb/bin:/Users/pradeep/bin:/Users/pradeep/play:/Users/pradeep/euphoria/bin:/Users/pradeep/.local/bin:/Users/pradeep/flexsdk3/bin:/Users/pradeep/grails/bin:/Library/Frameworks/Python.framework/Versions/Current/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:usr/texbin:/usr/X11/bin:/usr/local/Cellar/python/2.7.1/bin:/usr/local/texlive/2011/bin/x86_64-darwin

export PYTHONSTARTUP=$HOME/.pythonrc
export WORKON_HOME=$HOME/.virtualenvs
VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python
source /usr/local/bin/virtualenvwrapper.sh

export PATH="$PATH:$HOME/src/git-achievements"
alias git="git-achievements"
export PATH=/Users/pradeep/.gem/ruby/1.8/bin:$PATH
export PATH=/Users/pradeep/scripts:$PATH
export EDITOR="vim"
export ALTERNATE_EDITOR=""

## Go
export PATH=$HOME/go/bin:$PATH
## Lua

export LUA_PATH="/usr/local/lib/luarocks/share/lua/5.1/?.lua;/usr/local/lib/luarocks/share/lua/5.1/?/?.lua;/usr/local/lib/luarocks/lib/lua/5.1/?.lua;/usr/local/lib/luarocks/lib/lua/5.1/?/?.lua;${LUA_PATH}"
export LUA_CPATH="/usr/local/lib/luarocks/share/lua/5.1/?.so;/usr/local/lib/luarocks/share/lua/5.1/?/?.so;/usr/local/lib/luarocks/lib/lua/5.1/?.so;/usr/local/lib/luarocks/lib/lua/5.1/?/?.so;${LUA_CPATH}"


## ruby 1.9
export PATH=/usr/local/Cellar/ruby/1.9.2-p0/bin:$PATH
export PATH=/usr/local/gnat/bin:$PATH
export PATH=/usr/local/SPARK/bin:$PATH
export PATH=$HOME/.cabal/bin:$PATH
export PATH=$HOME/local/bin:$PATH

if [ -z "$SSH_AUTH_SOCK" ] ; then
        eval `ssh-agent -s`
            ssh-add
        fi

## Firebird
export FIREBIRD_HOME=/Library/Frameworks/Firebird.framework/Resources
export PATH=$PATH:$FIREBIRD_HOME/bin

## Clojure
export CLASSPATH=$CLASSPATH:/usr/local/Cellar/clojure-contrib/1.2.0/clojure-contrib.jar

#TexExec
export PATH=/usr/local/texlive/2010/bin/universal-darwin:$PATH

# Ocamlc rlwap
#alias ocaml='rlwrap ocaml'
alias emacs="/usr/local/bin/emacs"

export PATH=$HOME/nimrod/bin:$PATH
export PATH=/usr/local/share/python:$PATH


## Aliases
alias gcb='git add . && git commit -m "$(date +"%a, %d %b %Y")"'
alias gpom="git push origin master"
alias gpwm="git push web  master"
alias gpul="git pull origin master"
alias tug="git pull origin master"
export TEXINPUTS=$TEXINPUTS:"$HOME/texmy/tex/latex"
export PATH=$HOME/local/opendylan/bin:$PATH
export PATH=/usr/local/Cellar/smlnj/110.73/libexec/bin:$PATH
export PATH=/usr/local/share/npm/bin:$PATH
## Amazon EC2
export JAVA_HOME="/System/Library/Frameworks/JavaVM.framework/Home"
export EC2_PRIVATE_KEY="$(/bin/ls $HOME/.ec2/pk-*.pem)"
export EC2_CERT="$(/bin/ls $HOME/.ec2/cert-*.pem)"
export EC2_AMITOOL_HOME="/usr/local/Cellar/ec2-ami-tools/1.3-45758/jars"
export EC2_HOME=/usr/local
export LUA_PATH="/usr/local/lib/luarocks/share/lua/5.1/?.lua;/usr/local/lib/luarocks/share/lua/5.1/?/?.lua;/usr/local/lib/luarocks/lib/lua/5.1/?.lua;/usr/local/lib/luarocks/lib/lua/5.1/?/?.lua;/usr/local/lib/luarocks/share/lua/5.1/?.lua;/usr/local/lib/luarocks/share/lua/5.1/?/?.lua;/usr/local/lib/luarocks/lib/lua/5.1/?.lua;/usr/local/lib/luarocks/lib/lua/5.1/?/?.lua;/usr/local/lib/luarocks/share/lua/5.1/?.lua;/usr/local/lib/luarocks/share/lua/5.1/?/?.lua;/usr/local/lib/luarocks/lib/lua/5.1/?.lua;/usr/local/lib/luarocks/lib/lua/5.1/?/?.lua;/usr/local/share/luajit-2.0.0-beta9/?"
export HAXE_LIBRARY_PATH="$(brew --prefix)/share/haxe/std"

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

(which opam > /dev/null) && eval $(opam config -env)

## mailspool
export MAILDIR="$HOME/.mailspool"
export DEFAULT="$HOME/.mailspool/pradeep"
export PATH=/usr/local/Cellar/ruby/1.9.3-p374/bin:$PATH

#Fantom programming language
#export PATH=$PATH:$HOME/apps/fantom/bin

## Golang
export GOROOT=$HOME/go
export GOPATH=$GOROOT/bin
export GOBIN=$GOROOT/bin

## Jython
export PATH=$PATH:$HOME/apps/jython

## Elixir
export PATH=$PATH:$HOME/elixir/bin

## patdiff
git config --global alias.patdiff 'difftool -y -x patdiff'

[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh
