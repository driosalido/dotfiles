echo "› Installinf Fonts"
if test "$(uname)" = "Darwin"
then
  sudo cp $HOME/.dotfiles/fonts/*.ttf /Library/Fonts 
else
  sudo cp $HOME/.dotfiles/fonts/*.ttf ~/.local/share/fonts
fi