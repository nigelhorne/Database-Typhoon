#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include "typhoon.h"
#include "examples/openaddresses.h"


MODULE = Database::Typhoon		PACKAGE = Database::Typhoon		
PROTOTYPES: DISABLE

int
d_dbdpath(path)
	char *path

	CODE:
		RETVAL = d_dbdpath(path);
	OUTPUT:
		RETVAL

int
d_dbfpath(path)
	char *path

	CODE:
		RETVAL = d_dbdpath(path);
	OUTPUT:
		RETVAL

int
d_open(database, mode)
	char *database
	char *mode

	CODE:
		RETVAL = d_open(database, mode);
	OUTPUT:
		RETVAL

int
d_fillnew(recid, buf)
	unsigned long recid
	HV *buf

	CODE:
		/*
		 * TODO: map the incoming hash to a struct
		 */
		RETVAL = d_fillnew(recid, buf);
	OUTPUT:
		RETVAL

int
d_keyfrst(keyid)
	unsigned long keyid

	CODE:
		RETVAL = d_keyfrst(keyid);
	OUTPUT:
		RETVAL

int
d_delete()
	CODE:
		RETVAL = d_delete();
	OUTPUT:
		RETVAL

int
d_recread(buf)
	SV *buf;
	CODE:
		RETVAL = d_recread(buf);
		/*
		 * TODO: map the struct to an outgoing hash
		 */
	OUTPUT:
		RETVAL
