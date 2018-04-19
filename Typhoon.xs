#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include "typhoon.h"


MODULE = Database::Typhoon		PACKAGE = Database::Typhoon		

int
dt_d_open(database, mode)
	const char *database
	const char *mode

	CODE:
		RETVAL = d_open(database, mode);
	OUTPUT:
		RETVAL
