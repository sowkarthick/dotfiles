# Fancy-git
# https://www.pragmaticlinux.com/2022/06/show-the-git-branch-in-your-bash-terminal-prompt/

# Run the install script, this will update the bashrc file
curl -sS https://raw.githubusercontent.com/diogocavilha/fancy-git/master/install.sh | bash

# Apply the recommended Git color configuration
fancygit --suggested-global-git-config-apply

# Following command lists available color schemes
# fancygit --show-color-schemes

# set color scheme batman
fancygit --color-scheme-batman
