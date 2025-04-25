if [ ! -d ~/dinux ]; then
  mkdir ~/dinux
fi
if [ -d ~/dinux/$version ]; then
  rm -rf ~/dinux/$version
fi
cp -r dotfiles ~/dinux/$version
echo ":: Dinux i3 configuration prepared in ~/dinux/$version"
