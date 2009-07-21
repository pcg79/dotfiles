alias mobd='cd ~/dev/mobile_discovery/'
alias mda='mobd; autotest'
alias mdss='mobd; script/server'

alias mov='cd ~/dev/movie_alerts'
alias movlog='mov; cd log; tail -f development.log'
alias mova='mov; a'

alias inno='cd ~/dev/Innovectra'
alias innop='cd ~/dev/Innovectra/portal'

alias taillog='tail -f ./log/development.log'

# Nimcast
alias nim='cd ~/dev/nimcast_project/nimcast'

alias ncstart='$CATALINA_HOME/bin/catalina.sh jpda start'
alias ncstop='$CATALINA_HOME/bin/shutdown.sh'
alias ncrestart='ncstop; sleep 1; ncstart'

alias tomcat4='cd ~/dev/apache-tomcat-4.1.37/'
alias tomcat4log='cd ~/dev/apache-tomcat-4.1.37/logs'
alias tomcat5='cd ~/dev/apache-tomcat-5.5.26'
alias tomcat5log='cd ~/dev/apache-tomcat-5.5.26/logs'

alias casstart='~/dev/apache-tomcat-5.5.26/bin/catalina.sh jpda start'
alias casstop='~/dev/apache-tomcat-5.5.26/bin/shutdown.sh'
alias casrestart='casstop; sleep 1; casstart'

alias cas='cd ~/dev/nimcas_project/cas'

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
alias gd="git diff"
alias gl="git pull"
alias glr="git pull --rebase"
alias gp="git push"
alias gs="git status"
alias ga="git add"
alias glog="git log"
alias gsu="git submodule update"
alias gsd="git svn dcommit"
alias gsr="git svn rebase"

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

alias a="autotest"
alias smp="staticmatic preview ."

export GEMS=/opt/local/lib/ruby/gems/1.8/gems
function findgem {
  echo `ls $GEMS | grep -i $1 | sort | tail -1`
}

# Use: cdgem <name>, cd's into your gems directory
# that best matches the name provided.
function cdgem {
  cd $GEMS/`findgem $1`
}

# Use: gemdoc <gem name>, opens the rdoc of the gem
# that best matches the name provided.
function gemdoc {
  open $GEMS/../doc/`findgem $1`/rdoc/index.html
}

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
