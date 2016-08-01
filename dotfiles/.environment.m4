contains() {
    [ "${1#*$2}" != "$1" ]
}

contains :"$PATH": :"$HOME/bin": || PATH=$HOME/bin:$PATH
export "IDEA_VM_OPTIONS=$HOME/.IdeaIC13/idea$BITS.vmoptions"
export "GOPATH=$HOME/src/go"
export "XDG_DESKTOP_DIR=$HOME"
export PYTHONWARNINGS=all
export WINEDEBUG=-all
export BROWSER=sensible-browser
export GCC_COLORS=y
export _JAVA_OPTIONS="-Dswing.systemlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dawt.useSystemAAFontSettings=on -Dswing.aatext=true"
export SSH_ASKPASS="$(PATH=$PATH:/usr/lib/ssh; command -v x11-ssh-askpass)"
export SUDO_ASKPASS="$SSH_ASKPASS"
ifelse(HTTP_PROXY, `', `', ``export http_proxy='HTTP_PROXY')
export MAKEFLAGS=-j`'eval(CPUS + 1)
