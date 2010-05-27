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
if [ -d /opt/local/lib/postgresql83/bin/ ] ; then
  PATH="${PATH}:/opt/local/lib/postgresql83/bin/"
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

# Do not set PS1 for dumb terminals
if [ "$TERM" != 'dumb'  ] && [ -n "$BASH" ]
then
  export PS1='\[\033[32m\]\n[\s: \w]\n\[\033[31m\][\u@\h]\$ \[\033[00m\]'
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
## History
############################################################
 
# When you exit a shell, the history from that session is appended to
# ~/.bash_history.  Without this, you might very well lose the history of entire
# sessions (weird that this is not enabled by default).
shopt -s histappend
 
export HISTIGNORE="&:pwd:ls:ll:lal:[bf]g:exit:rm*:sudo rm*"
# remove duplicates from the history (when a new item is added)
export HISTCONTROL=erasedups
# increase the default size from only 1,000 items
export HISTSIZE=10000
 
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
## Bash Completion, if available
############################################################

if [ -f /opt/local/etc/bash_completion ]; then
  . /opt/local/etc/bash_completion
elif  [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
elif  [ -f /etc/profile.d/bash_completion ]; then
  . /etc/profile.d/bash_completion
fi

# http://onrails.org/articles/2006/11/17/rake-command-completion-using-rake
if [ -f ~/bin/rake_completion ]; then
  complete -C ~/bin/rake_completion -o default rake
fi

if [ -f ~/bin/git_completion ]; then
  . ~/bin/git_completion 
fi

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
## Oracle
############################################################

# Must match kern.maxprocperuid
ulimit -Hu 512
ulimit -Su 512
# Must match kern.maxfilesperproc
ulimit -Hn 10240
ulimit -Sn 10240

export ORACLE_BASE=/Users/oracle/oracle
export ORACLE_HOME=$ORACLE_BASE/product/10.2.0/db_1
export DYLD_LIBRARY_PATH=$ORACLE_HOME/lib:$DYLD_LIBRARY_PATH
export ORACLE_SID=dev
export TNS_ADMIN=$ORACLE_HOME/lib
PATH=$PATH:$ORACLE_HOME/bin

# start Oracle and listener
alias ostart="sudo -u oracle /bin/bash -l -c '$ORACLE_HOME/bin/dbstart $ORACLE_HOME'"
# shutdown Oracle and listener
alias ostop="sudo -u oracle /bin/bash -l -c '$ORACLE_HOME/bin/dbshut $ORACLE_HOME'"

############################################################
