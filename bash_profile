export GREP_OPTIONS='--color=auto'

# Binary Paths
subl_bin="/Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl"

# Aliases
alias subl="${subl_bin} --add"
alias ls='ls -G'
alias ll="ls -Al"
alias lh="ls -Alrth"
alias dt='date "+%F %T"'
alias php='php -d report_memleaks=1 -d report_zend_debug=1 -d log_errors=0 -d ignore_repeated_errors=0 -d ignore_repeated_source=0 -d error_reporting=30719 -d display_startup_errors=1 -d display_errors=1'
#alias grep='grep --color=auto'

# Custom Functions
function cl(){ cd "$@" && la; }
function cdn(){ for i in `seq $1`; do cd ..; done; }
extract () {
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       rar x $1       ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *)           echo "don't know how to extract '$1'..." ;;
      esac
  else
      echo "'$1' is not a valid file!"
  fi
}