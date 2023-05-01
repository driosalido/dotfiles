if test "$(uname)" = "Darwin"
then
  echo "› sudo softwareupdate -i -a"
  sudo softwareupdate -i -a
  exit 0
fi

