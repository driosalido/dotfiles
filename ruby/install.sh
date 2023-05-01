if test "$(uname)" = "Darwin"
then
  brew_gem_bin="/usr/local/opt/ruby/bin/gem"
else
  brew_gem_bin="/home/linuxbrew/.linuxbrew/bin/gem"
fi

if test ! $(which colorls);then
  echo "› install colorls"
  sudo $brew_gem_bin install colorls 
fi
