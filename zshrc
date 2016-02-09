# DESCRIPTION:
#   A simple zsh configuration that gives you 90% of the useful features that I use everyday.
#
# AUTHOR:
#   Geoffrey Grosenbach http://peepcode.com

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

plugins=(rails git bundler brew zsh-syntax-highlighting history-substring-search)

source $ZSH/oh-my-zsh.sh
source ~/.scripts/ls_scripts
source ~/.scripts/gimme
source ~/.scripts/lol

# git aliased to hub
# Note: Requires hub (https://github.com/github/hub)
eval "$(hub alias -s)"

# RVM
if [[ -s ~/.rvm/scripts/rvm ]] ; then source ~/.rvm/scripts/rvm ; fi

# Colors
autoload -U colors
colors
setopt prompt_subst

# Prompt
local smiley="%(?,%{$fg[green]%}☺%{$reset_color%},%{$fg[red]%}☹%{$reset_color%})"

PROMPT='
%{$fg[cyan]%}%~
${smiley}  %{$reset_color%}'

RPROMPT='%{$fg[white]%} $(~/.rvm/bin/rvm-prompt)$(~/bin/git-cwd-info)%{$reset_color%}'

# Replace the above with this if you use rbenv
# RPROMPT='%{$fg[white]%} $(~/.rbenv/bin/rbenv version-name)$(~/bin/git-cwd-info.rb)%{$reset_color%}'

# Show completion on first TAB
setopt menucomplete

function prodshell () {
  if [ -z "$1" ]; then
    ssh app-shell01.iad.livingsocial.net RAILS_ENV=production /usr/local/bin/apprubyexec $1 bundle exec rails console
  else
    PROJECT_NAME=`ruby -ryaml -e "data = YAML::load(File.read('manifest.yml')); puts data['app']"`
    ssh app-shell01.iad.livingsocial.net RAILS_ENV=production /usr/local/bin/apprubyexec $PROJECT_NAME bundle exec rails console
  fi
}

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
alias ber="bundle exec rake"

alias appshell="ssh app-shell01.iad.livingsocial.net"

# Oct 21, 2013.  At some point the bundler plugin changed to alias bi to "bundle install --jobs=8".
# The version of bundler I'm using doesn't allow the jobs switch.  So this alias is an override.
alias bi="bundle install"

# Convenience method
function doit() {
  if [ -n "$1" ]; then
    cd "$HOME/dev/$1"
    if [ $? -eq 0 ]; then
      subl . && gco master && gpum && git push && bi
    else
      echo "That directory doesn't exist.  Exiting"
    fi
  fi
}

# Customize to your needs...
# export PATH=/usr/local/bin:/usr/local/sbin:/Users/patrickgeorge/bin:/Users/patrickgeorge/.rvm/gems/ruby-1.9.3-p286/bin:/Users/patrickgeorge/.rvm/gems/ruby-1.9.3-p286@global/bin:/Users/patrickgeorge/.rvm/rubies/ruby-1.9.3-p286/bin:/Users/patrickgeorge/.rvm/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin

# Setting PATH for Python 3.3
PATH=$PATH:/Library/Frameworks/Python.framework/Versions/3.3/bin
PATH=/usr/local/bin:$PATH
PATH=/usr/local/sbin:$PATH
#PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
PATH=$PATH:$HOME/bin

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

