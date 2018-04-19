#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include "typhoon.h"


MODULE = Database::Typhoon		PACKAGE = Database::Typhoon		
PROTOTYPES: DISABLE

int
d_dbdpath(path)
	const char *path

	CODE:
		RETVAL = d_dbdpath(path);
	OUTPUT:
		RETVAL

int
d_dbfpath(path)
	const char *path

	CODE:
		RETVAL = d_dbdpath(path);
	OUTPUT:
		RETVAL

int
d_open(database, mode)
	const char *database
	const char *mode

	CODE:
		RETVAL = d_open(database, mode);
	OUTPUT:
		RETVAL
