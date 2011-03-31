## This file is sourced by all *interactive* bash shells on startup.  This
## file *should generate no output* or it will break the scp and rcp commands.
############################################################

if [ -e /etc/bashrc ] ; then
  . /etc/bashrc
fi

############################################################
## PATH
############################################################

if [ -d ~/bin ] ; then
  PATH="~/bin:${PATH}"
fi

if [ -d /usr/local/bin ] ; then
  PATH="${PATH}:/usr/local/bin"
fi

# MacPorts
if [ -d /opt/local/bin ] ; then
  PATH="/opt/local/bin:${PATH}"
fi
if [ -d /opt/local/sbin ] ; then
  PATH="/opt/local/sbin:${PATH}"
fi

# MySql
if [ -d /usr/local/mysql/bin ] ; then
  PATH="${PATH}:/usr/local/mysql/bin"
fi

# PostgreSQL
if [ -d /opt/local/lib/postgresql91/bin ] ; then
  PATH="${PATH}:/opt/local/lib/postgresql91/bin"
fi

# Subversion
if [ -d /opt/subversion/bin ] ; then
  PATH="/opt/subversion/bin:${PATH}"
fi

# Gem 1.8
if [ -d /Users/patgeorge/.gem/ruby/1.8/bin ] ; then
  PATH="~/.gem/ruby/1.8/bin:${PATH}"
fi

# nginx
if [ -d /opt/nginx/sbin ] ; then
  PATH="/opt/nginx/sbin:${PATH}"
fi

# RVM
if [ -d ~/.rvm/bin ] ; then
  PATH="~/.rvm/bin:${PATH}"
fi

# MongoDB
if [ -d ~/dev/mongodb-osx-x86_64-1.6.2/bin ] ; then
  PATH="~/dev/mongodb-osx-x86_64-1.6.2/bin:${PATH}"
fi

PATH=.:${PATH}

############################################################
## Other paths
############################################################

# MacPorts
if [ -d /opt/local/share/man ] ; then
  MANPATH="/opt/local/share/man:${MANPATH}"
fi
# Set MANPATH so it includes users' private man if it exists
# if [ -d ~/man ]; then
#   MANPATH="~/man:${MANPATH}"
# fi

# Set INFOPATH so it includes users' private info if it exists
# if [ -d ~/info ]; then
#   INFOPATH="~/info:${INFOPATH}"
# fi

# DYLD_LIBRARY_PATH
if [[ `uname` == 'Darwin' ]]; then
  if [ -d /opt/local/lib ] ; then
    DYLD_LIBRARY_PATH="/opt/local/lib:${DYLD_LIBRARY_PATH}"
  fi
#   if [ -d /opt/subversion/lib ] ; then
#     DYLD_LIBRARY_PATH="/opt/subversion/lib:${DYLD_LIBRARY_PATH}"
#   fi
fi

############################################################
## Terminal behavior
############################################################

# Change the window title of X terminals
case $TERM in
  xterm*|rxvt|Eterm|eterm)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
    ;;
  screen)
    PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"'
    ;;
esac


# Show the git branch and dirty state in the prompt.
# Borrowed from: http://henrik.nyh.se/2008/12/git-dirty-prompt
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\(\1$(parse_git_dirty)\)/"
}

# Display branch in prompt
# From http://railstips.org/blog/archives/2009/02/02/bedazzle-your-bash-prompt-with-git-info/
function parse_git_branch_prompt {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "("${ref#refs/heads/}") "
}

RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"



if [ "$TERM" != 'dumb'  ] && [ -n "$BASH" ]
then
  export PS1="$GREEN\n[\s: \w]\n$RED[\u@\h] $YELLOW\$(parse_git_branch_prompt)$GREEN\$ " 
fi

############################################################
## Optional shell behavior
############################################################

shopt -s cdspell
shopt -s extglob
shopt -s checkwinsize

export PAGER="less"
export HISTIGNORE="&:pwd:ls:ll:lal:[bf]g:exit:rm*:sudo rm*"
export EDITOR="vi"


############################################################
## RVM Shell
############################################################

## PS1="\$(~/.rvm/bin/rvm-prompt) $PS1"

############################################################
## History
############################################################
 
# A lot of this taken from here:
# http://stackoverflow.com/questions/103944/real-time-history-export-amongst-bash-terminal-windows

# When you exit a shell, the history from that session is appended to
# ~/.bash_history.  Without this, you might very well lose the history of entire
# sessions (weird that this is not enabled by default).
shopt -s histappend
## reedit a history substitution line if it failed
shopt -s histreedit
## edit a recalled history line before executing
shopt -s histverify
 
export HISTIGNORE="&:pwd:ls:ll:lal:[bf]g:exit:rm*:sudo rm*"
# remove duplicates from the history (when a new item is added)
export HISTCONTROL=ignoredups:erasedups
# increase the default size from only 1,000 items
export HISTSIZE=10000
export HISTFILESIZE=100000 

# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMA"
 
# By default up/down are bound to previous-history and next-history
# respectively. The following does the same but gives the extra functionality
# where if you type any text (or more accurately, if there is any text between
# the start of the line and the cursor), the subset of the history starting with
# that text is searched.
bind '"\e[A"':history-search-backward
bind '"\e[B"':history-search-forward

## From http://www.commandlinefu.com/commands/view/2158/add-timestamp-to-history
export HISTTIMEFORMAT="%F %T " 

############################################################
## Aliases
############################################################

if [ -e ~/.bash_aliases ] ; then
  . ~/.bash_aliases
fi


############################################################
## Completions
############################################################

# From https://github.com/jpalardy/dotfiles
for file in $HOME/.bash/completion/*; do
  source $file
done

############################################################
## Other
############################################################

if [[ "$USER" == '' ]]; then
  # mainly for cygwin terminals. set USER env var if not already set
  USER=$USERNAME
fi

# MacPorts OpenSSL doesn't have a ca bundle, so piggy back on Curl's
if [ -f /opt/local/share/curl/curl-ca-bundle.crt ] ; then
  export SSL_CERT_FILE="/opt/local/share/curl/curl-ca-bundle.crt"
fi

############################################################
## z (from https://github.com/rupa/z)
############################################################

if [ -f /Users/patgeorge/bin/z/z.sh ] ; then
  . /Users/patgeorge/bin/z/z.sh
fi

