# DESCRIPTION:
#   A simple zsh configuration that gives you 90% of the useful features that I use everyday.
#
# AUTHOR:
#   Geoffrey Grosenbach http://peepcode.com
ZSH_DISABLE_COMPFIX=true
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

export ARCHFLAGS="-arch x86_64"

plugins=(rails git bundler brew history-substring-search chruby zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
# source ~/.scripts/ls_scripts
# source ~/.scripts/gimme
# source ~/.scripts/lol
# source /usr/local/opt/chruby/share/chruby/chruby.sh
# source /usr/local/opt/chruby/share/chruby/auto.sh

# git aliased to hub
# Note: Requires hub (https://github.com/github/hub)
eval "$(hub alias -s)"

# FreeAgent devkit
#  This is the result of   eval "$(devkit env vars)"
# It's faster to not make that call
export DB_HOST=127.0.0.1
export STATSD_HOST=localhost
export GRAPHITE_HOST=localhost
export FREEAGENT_CACHE_STORE=memcached

# RVM
if [[ -s $HOME/.rvm/scripts/rvm ]] ; then source $HOME/.rvm/scripts/rvm ; fi

# Colors
autoload -U colors
colors
setopt prompt_subst

# Prompt
local smiley="%(?,%{$fg[green]%}😄%{$reset_color%},%{$fg[red]%}😞%{$reset_color%})"

PROMPT='
%{$fg[cyan]%}%~
${smiley}  %{$reset_color%}'

RPROMPT='%{$fg[white]%} $(chruby_prompt_info)$(~/bin/git/git-cwd-info)%{$reset_color%}'

# Replace the above with this if you use rbenv
# RPROMPT='%{$fg[white]%} $(~/.rbenv/bin/rbenv version-name)$(~/bin/git-cwd-info.rb)%{$reset_color%}'

# Show completion on first TAB
setopt menucomplete

# Git aliases I prefer over the ones in the git plugin
alias gs="gst"
alias gd="git diff"
alias glr="git pull --rebase"
alias gpum="git pull upstream master"

# I had to comment out the gco alias in ~/.oh-my-zsh/plugins/git/git.plugin.zsh
function gco() {
  if [ -z "$1" ]; then
    git checkout master
  else
    git checkout $*
  fi
}
compdef _git gco=git-checkout # so tab completion will work

# Other aliases
alias l="ls -al"
alias rc="rails c"
alias rs="bundle exec rails server -b 0.0.0.0"  # rs is defined in the rails zsh plugin but I'm overwriting it to bind to all local addies

# Oct 21, 2013.  At some point the bundler plugin changed to alias bi to "bundle install --jobs=8".
# The version of bundler I'm using doesn't allow the jobs switch.  So this alias is an override.
alias bi="bundle install"

alias fs="foreman start"

# Convenience method
function doit() {
  if [ -n "$1" ]; then
    cd "$HOME/dev/$1"
    if [ $? -eq 0 ]; then
      subl . && gco master && git pull && bi
    else
      echo "That directory doesn't exist.  Exiting"
    fi
  fi
}

function hgrep() {
  history | grep "$1"
}  

# FreeAgent aliases
alias fa="cd ~/dev/freeagent"
alias standup="open http://meet.google.com/eib-qwth-zka"
alias vpn="devkit vpn up --2fa 'Corporate VPN V3.0'"

# Customize to your needs...
# export PATH=/usr/local/bin:/usr/local/sbin:/Users/patrickgeorge/bin:/Users/patrickgeorge/.rvm/gems/ruby-1.9.3-p286/bin:/Users/patrickgeorge/.rvm/gems/ruby-1.9.3-p286@global/bin:/Users/patrickgeorge/.rvm/rubies/ruby-1.9.3-p286/bin:/Users/patrickgeorge/.rvm/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin

# For nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm

# Setting PATH for Python 3.3
# PATH=/usr/local/bin:$PATH
PATH=/usr/local/sbin:$PATH
PATH=$PATH:$HOME/bin
PATH=/usr/local/opt/mysql@5.6/bin:$PATH

# Deleting keybindings
bindkey    "^[[4~"          delete-char
bindkey    "^[3;5~"         delete-char

# Next/Prev word keybindings
bindkey '^[^[[C' emacs-forward-word
bindkey '^[^[[D' emacs-backward-word

# history key bindings
# zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# glob searching
bindkey "\C-r" history-incremental-pattern-search-backward

# enable tab completion
autoload -U compinit
compinit -i

# Switch to Ruby 2.6.5 by default. Needs to come before the devkit line or it can't find that gem
chruby ruby-2.7.1
