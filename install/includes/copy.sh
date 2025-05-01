# Remove existing symlinks
for df in "${backup_files[@]}"; do
  if [ -L "${df}" ]; then
    rm ${df}
    echo ":: Symlink $df removed"
  fi
done

# Copy configuration to dotfiles folder
if [ -f ~/dinux-excludes.txt ]; then
  echo ":: Exclude file for rsync found"
  rsync -avhp -I --exclude-from=~/dinux-excludes.txt ~/dinux/$version/ ~/
else
  rsync -avhp -I ~/dinux/$version/ ~/
fi
echo ":: Dotfiles installed in ~/.config/"
