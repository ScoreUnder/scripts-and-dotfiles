contains() {
    [ "${1#*$2}" != "$1" ]
}
`
contains :"$PATH": :"$HOME/.local/bin": || PATH=$HOME/.local/bin:$PATH
export "IDEA_VM_OPTIONS=$HOME/.IdeaIC13/idea$BITS.vmoptions"
export "GOPATH=$HOME/src/go"
export "XDG_DESKTOP_DIR=$HOME"
export WINEDEBUG=-all
export BROWSER=sensible-browser
export GCC_COLORS=y
export _JAVA_OPTIONS="-Dswing.systemlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dawt.useSystemAAFontSettings=on -Dswing.aatext=true"
export SSH_ASKPASS="$(PATH=$PATH:/usr/lib/ssh; command -v x11-ssh-askpass)"
export SUDO_ASKPASS="$SSH_ASKPASS"
'ifelse(HTTP_PROXY, `', `', ``export http_proxy='HTTP_PROXY
')dnl
export MAKEFLAGS=-j`'eval(CPUS + 1)
ifelse(DISTRO, `arch', `export DEBUGINFOD_URLS="https://debuginfod.archlinux.org"
', `')dnl
`

# {{{ AMDGPU Vulkan driver selection
#export VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/radeon_icd.i686.json:/usr/share/vulkan/icd.d/radeon_icd.x86_64.json
#export DISABLE_LAYER_AMD_SWITCHABLE_GRAPHICS_1=1
export AMD_VULKAN_ICD=RADV
# }}}
'ifelse(PERL_LOCAL_LIB, `true',
``# {{{ perl local::lib
PATH="$HOME/.local/share/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="$HOME/.local/share/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="$HOME/.local/share/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"$HOME/.local/share/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=$HOME/.local/share/perl5"; export PERL_MM_OPT;
# }}}
'')dnl
`# {{{ Default ssh-gpg
_default_to_ssh_gpg() {
    local authsock
    authsock="${XDG_RUNTIME_DIR:-/run/user/${UID:-$(id -u)}}/gnupg/S.gpg-agent.ssh"
    [ -e "$authsock" ] && export SSH_AUTH_SOCK="$authsock"
    [ -n "$TTY" ] && export GPG_TTY="$TTY"
}
_default_to_ssh_gpg
unset -f _default_to_ssh_gpg
# }}}'
