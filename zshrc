# DESCRIPTION:
#   A simple zsh configuration that gives you 90% of the useful features that I use everyday.
#
# AUTHOR:
#   Geoffrey Grosenbach http://peepcode.com

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

plugins=(rails rails3 git bundler brew)

source $ZSH/oh-my-zsh.sh

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

# Git aliases I prefer over the ones in the git plugin
alias gs="gst"
alias gd="git diff"
alias glr="git pull --rebase"

# Customize to your needs...
export PATH=/usr/local/bin:/usr/local/sbin:/Users/patrickgeorge/bin:/Users/patrickgeorge/.rvm/gems/ruby-1.9.3-p286/bin:/Users/patrickgeorge/.rvm/gems/ruby-1.9.3-p286@global/bin:/Users/patrickgeorge/.rvm/rubies/ruby-1.9.3-p286/bin:/Users/patrickgeorge/.rvm/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin

bindkey    "^[[3~"          delete-char
bindkey    "^[3;5~"         delete-char

# load zsh specific stuff
# for config_file ($ZSH/lib/*.zsh) source $config_file

# enable tab completion
autoload -U compinit
compinit -i
