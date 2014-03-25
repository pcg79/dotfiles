# DESCRIPTION:
#   A simple zsh configuration that gives you 90% of the useful features that I use everyday.
#
# AUTHOR:
#   Geoffrey Grosenbach http://peepcode.com

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

plugins=(rails git bundler brew jira zsh-syntax-highlighting history-substring-search)

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
alias gpum="git pull upstream master"

# Other aliases
alias l="ls -al"
alias rc="rails c"
alias ber="bundle exec rake"

# Oct 21, 2013.  At some point the bundler plugin changed to alias bi to "bundle install --jobs=8".
# The version of bundler I'm using doesn't allow the jobs switch.  So this alias is an override.
alias bi="bundle install"

function runtests {
  date
  export PARALLEL_TEST_PROCESSORS=6
  ber test:prepare_parallel
  ber test:no_rails

  echo "***** UNITS"
  date
  time ber 'parallel:test[^test/unit]'

  echo "***** FUNCTIONAL/INTEGRATION"
  date
  time ber 'parallel:test[^test/functional|^test/integ]' 

  echo "***** ENDRUN"
  date
}

function runpipelinetests {
  date
  export PARALLEL_TEST_PROCESSORS=6
  ber test:prepare_parallel

  echo "***** FAST TESTS"
  date
  ber test:fast

  echo "***** UNITS"
  date
  ber 'parallel:test[^test/unit]'

  echo "***** FUNCTIONAL/INTEGRATION"
  date
  ber 'parallel:test[^test/functional|^test/integ]' 

  echo "**** ENDRUN"
  date
}

# Customize to your needs...
# export PATH=/usr/local/bin:/usr/local/sbin:/Users/patrickgeorge/bin:/Users/patrickgeorge/.rvm/gems/ruby-1.9.3-p286/bin:/Users/patrickgeorge/.rvm/gems/ruby-1.9.3-p286@global/bin:/Users/patrickgeorge/.rvm/rubies/ruby-1.9.3-p286/bin:/Users/patrickgeorge/.rvm/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin

# Setting PATH for Python 3.3
PATH=$PATH:/Library/Frameworks/Python.framework/Versions/3.3/bin
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
PATH=$PATH:$HOME/bin

bindkey    "^[[4~"          delete-char
bindkey    "^[3;5~"         delete-char
bindkey '^[^[[C' emacs-forward-word
bindkey '^[^[[D' emacs-backward-word

# history key bindings
# zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# enable tab completion
autoload -U compinit
compinit -i
