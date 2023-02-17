#!/bin/sh
# Start fbterm with a random background image and the tewi font
img=$(bg-random -n; echo x); img=${img%??}
exec fbterm-bg "$img" -n 'FREETYPE_NEW_NAME(`lucy', `Tewi')'
