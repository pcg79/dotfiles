alias mobd='cd ~/dev/mobile_discovery/'
alias mda='mobd; autotest'
alias mdss='mobd; script/server'

alias mov='cd ~/dev/movie_alerts'
alias movlog='mov; cd log; tail -f development.log'
alias mova='mov; a'

alias inno='cd ~/dev/Innovectra'
alias innop='cd ~/dev/Innovectra/portal'

alias short='cd ~/dev/shortswitch'

alias taillog='tail -f ./log/development.log'

alias rails3="rvm use ruby-1.9.2-head@rails3"

alias joy="cd ~/dev/joys_cake; rails3"

# alias nim='cd ~/dev/nimcast_project/nimcast'
# alias ncstart='$CATALINA_HOME/bin/catalina.sh jpda start'
# alias ncstop='$CATALINA_HOME/bin/shutdown.sh'
# alias ncrestart='ncstop; sleep 1; ncstart'

# alias tomcat4='cd ~/dev/apache-tomcat-4.1.37/'
# alias tomcat4log='cd ~/dev/apache-tomcat-4.1.37/logs'
alias tomcat5='cd ~/dev/apache-tomcat-5.5.26'
alias tomcat5log='cd ~/dev/apache-tomcat-5.5.26/logs'

alias casstart='~/dev/apache-tomcat-5.5.26/bin/catalina.sh jpda start'
alias casstop='~/dev/apache-tomcat-5.5.26/bin/shutdown.sh'
alias casrestart='casstop; sleep 1; casstart'
alias cas='cd ~/dev/nimcas_project/cas'

alias nginxstart="sudo nginx"
alias nginxstop="sudo nginx -s stop"

alias apachestart="sudo apachectl -k restart"
alias apachestop="sudo apachectl -k stop"

alias retire="cd ~/dev/retirehq"
alias paystub="cd ~/dev/paystubhq"

alias cast="cd ~/dev/cast"

alias stalker="cd ~/dev/urlstalker; rails3"

alias case_medical="cd ~/dev/case_medical; rails3"

alias cap_web="cd ~/dev/cap/web"

# -- Bundler aliases
alias b='bundle'

# This gets used daily
alias be='b exec'

# This gets used daily
alias bu="b update"

# Run this whenever there's an update to the Gemfile; regularly used.
alias bi='b install --path vendor'

# Run this the first time you add bundler to a project; rarely used.
alias binit='bi && b package && echo '\''vendor/ruby'\'' >> .gitignore'

# Using this jazz, your app's gem dependencies will be
# * be packaged and a part of version control (finely controlled dependencies, reliable deployments).
# * the unpacked libraries aren't checked in (clean).

# Credit to Ryan McGeary (@rmm5t) for these aliases.

# -- Bundler aliases --

nc-cas ()
{
  ant_lib=~/dev/apache-ant-1.6.5/lib
  # If $ant_lib/catalina-ant.jar.4 exists, change it to ....jar and the existing ...jar to ...jar.5
  # and vice versa
  if [ -f "$ant_lib/catalina-ant.jar.4" ]
  then
    echo "Currently configured for Tomcat 5.  Switching to Tomcat 4."
    `mv $ant_lib/catalina-ant.jar $ant_lib/catalina-ant.jar.5`
    `mv $ant_lib/catalina-ant.jar.4 $ant_lib/catalina-ant.jar`
    CATALINA_HOME=~/dev/apache-tomcat-4.1.37/
  elif [ -f "$ant_lib/catalina-ant.jar.5" ]
  then
    echo "Currently configured for Tomcat 4.  Switching to Tomcat 5."
    `mv $ant_lib/catalina-ant.jar $ant_lib/catalina-ant.jar.4`
    `mv $ant_lib/catalina-ant.jar.5 $ant_lib/catalina-ant.jar`
    CATALINA_HOME=~/dev/apache-tomcat-5.5.26/
  else
    echo "Neither file exists."
  fi
}

# Adds an alias to the current shell and to this file.
# Borrowed from Mislav (http://github.com/mislav/dotfiles/tree/master/bash_aliases)
add-alias ()
{
   local name=$1 value=$2
   echo "alias $name='$value'" >> ~/.bash_aliases
   eval "alias $name='$value'"
   alias $name
}

############################################################
## List
############################################################

if [[ `uname` == 'Darwin' ]]; then
  alias ls="ls -G"
  # good for dark backgrounds
  export LSCOLORS=gxfxcxdxbxegedabagacad
else
  alias ls="ls --color=auto"
  # good for dark backgrounds
  export LS_COLORS='no=00:fi=00:di=00;36:ln=00;35:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=00;31:'
  # For LS_COLORS template: $ dircolors /etc/DIR_COLORS
fi

alias l="ls -la"
alias ll="ls -l"
alias la="ls -a"
alias lal="ls -al"

############################################################
## Git
############################################################

alias g="git"
alias gb="git branch -a -v"
alias gc="git commit -v"
alias gca="git commit -v -a"
alias gd="git diff --ignore-space-at-eol"
alias gl="git pull"
alias glr="git pull --rebase"
alias gp="git push"
alias gs="git status"
alias ga="git add"
alias gg="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias ggs="gg --stat"
alias gsu="git submodule update"
alias gsd="git svn dcommit"
alias gsr="git svn rebase"
# alias grm="git rm $(git ls-files --deleted)"

# Useful report of what has been committed locally but not yet pushed to another
# branch.  Defaults to the remote origin/master.  The u is supposed to stand for
# undone, unpushed, or something.
function gu {
  local branch=$1
  if [ -z "$1" ]; then
    branch=master
  fi
  if [[ ! "$branch" =~ "/" ]]; then
    branch=origin/$branch
  fi
  local cmd="git cherry -v $branch"
  echo $cmd
  $cmd
}

function gco {
  if [ -z "$1" ]; then
    git checkout master
  else
    git checkout $*
  fi
}

function st {
  if [ -d ".svn" ]; then
    svn status
  else
    git status
  fi
}

############################################################
## Subversion
############################################################

# Remove all .svn folders from directory recursively
alias svn-clean='find . -name .svn -print0 | xargs -0 rm -rf' 

############################################################
## OS X
############################################################

# Get rid of those pesky .DS_Store files recursively
alias dstore-clean='find . -type f -name .DS_Store -print0 | xargs -0 rm'

# Track who is listening to your iTunes music
alias whotunes='lsof -r 2 -n -P -F n -c iTunes -a -i TCP@`hostname`:3689'

# Reload /etc/hosts file
alias reload-hosts='dscacheutil -flushcache'

############################################################
## Ruby
############################################################

alias a="be autotest"

############################################################
## Rails
############################################################

alias ss="script/server"
alias sg="script/generate"
alias sc="script/console"
alias sp="script/plugin"

function ssp {
  if [ -z "$1" ]; then
    script/server 
  else
    script/server -p $1
  fi

}
############################################################
## Miscellaneous
############################################################

alias wgeto="wget -q -O -"
alias sha1="openssl dgst -sha1"
alias sha2="openssl dgst -sha256"

############################################################
