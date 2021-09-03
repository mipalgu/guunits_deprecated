#
#	$Id$
#
# Makefile for pre- and cross-compiling .machine files
#
ALL_TARGETS=show-all-dependencies
NO_DEFAULT_DEPENDENCIES_TARGETS=yes

CMAKE_SUBDIR_NAMES?=guunits
SUBDIR_NAMES?=${CMAKE_SUBDIR_NAMES} guunits_generator swift_GUUnits

.include "../../mk/subdir.mk"

generate:
	$Ecd guunits && ${MAKE} generate

.include "../../mk/mipal.mk"	# comes last!

