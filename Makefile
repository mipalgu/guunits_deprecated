#
# Makefile
# Callum McColl, 2019-06-05 11:58
#

ALL_TARGETS=host-local robot-local

C_SRCS!=ls *.c
CC_SRCS!=ls *.cc
ALL_HDRS!=ls *.h

.include "../../mk/c++17.mk"

${MODULE_BASE}_HDRS=${ALL_HDRS}
PKGCONFIG_NAME=guunits
PKGCONFIG_VERSION=1.0
PKGCONFIG_DESCRIPTION=Simple units library.

all:	all-real

generate:
	$Eecho "Generating guunits..."
	$E[ -f swift_GUUnits/Package.swift ] || (echo "The submodule swift_GUUnits does not exist!" && exit 1); 
	$Ecd guunits_generator && swift build
	$E./guunits_generator/.build/debug/guunits_generator
	$Emv *.swift swift_GUUnits/Sources/GUUnits/
	$Eecho "Make sure you commit the newly generated files in swift_GUUnits"


.include "../../mk/mipal.mk"


# vim:ft=make
#
