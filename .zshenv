export QT_QPA_PLATFORMTHEME=qt6ct
export PATH=$HOME/bin:/usr/local/bin:$PATH:$HOME/.local/bin
export EDITOR=/usr/bin/emacs

export PATH=$PATH:$HOME/.cargo/bin
# . "$HOME/.cargo/env"

# scaling hidpi apps
if [[ $HOST = "q3dm6"  ]]
then
export GDK_DPI_SCALE=0.5
export GDK_SCALE=2
fi

