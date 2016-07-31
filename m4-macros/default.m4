divert(-1)
An acceptable reference for m4:
http://www.cs.stir.ac.uk/~kjt/research/pdf/expl-m4.pdf

If you don't have GNU m4, this will probably not work. esyscmd is not POSIX.
define(`HOSTNAME', esyscmd(`hostname | tr -d \\n'))

include(`host-default.m4')
sinclude(`host-'HOSTNAME`.m4')

divert(0)dnl
