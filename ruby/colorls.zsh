
if test "$(uname)" = "Darwin"
then
  brew_gem_bin="/usr/local/opt/ruby/bin/gem"
else
  brew_gem_bin="/home/linuxbrew/.linuxbrew/bin/gem"
fi
source $(dirname $($brew_gem_bin which colorls))/tab_complete.sh
unset brew_gem_bin