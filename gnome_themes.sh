# clone the repo into "$HOME/src/gogh"
# https://gogh-co.github.io/Gogh/
mkdir -p "$HOME/src"
cd "$HOME/src"
git clone https://github.com/Gogh-Co/Gogh.git gogh
cd gogh/themes

# necessary on ubuntu
export TERMINAL=gnome-terminal

# install themes
./dark-pastel.sh
./dissonance.sh
./hemisu-dark.sh
./homebrew.sh
./hurtado.sh
./ibm3270-hicontrast.sh
./ibm3270.sh
./ir-black.sh
./liquid-carbon-transparent.sh
./mathias.sh
./nightlion-v1.sh
./nightlion-v2.sh
./one-half-black.sh
./paul-millr.sh
./peppermint.sh
# default pro
./pro.sh
./symphonic.sh
./tomorrow-night-bright.sh
./vibrant-ink.sh
./wez.sh
