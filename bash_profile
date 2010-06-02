# ~/.bash_profile: executed by bash for login shells.

if [ -e ~/.bashrc ] ; then
  . ~/.bashrc
fi

# Local customizations go below

if [ -e ~/.bash_env ] ; then
  . ~/.bash_env
fi

##
# Your previous /Users/patgeorge/.bash_profile file was backed up as /Users/patgeorge/.bash_profile.macports-saved_2009-09-02_at_16:06:39
##

# MacPorts Installer addition on 2009-09-02_at_16:06:39: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

#RVM (http://rvm.beginrescueend.com)
if [[ -s "$HOME/.rvm/scripts/rvm" ]]  ; then source "$HOME/.rvm/scripts/rvm" ; fi
