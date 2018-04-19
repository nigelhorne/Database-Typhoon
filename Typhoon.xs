// #define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include "typhoon.h"
#include "examples/openaddresses.h"

static const char *
get_string(HV *hash, const char *field)
{
	SV **sv = hv_fetch(hash, field, strlen(field), FALSE);
	if(sv == NULL) {
		return NULL;
	}
	if(!SvOK(*sv)) {
		fprintf(stderr, "Error trying to get 'field'\n", field);
		return NULL;
	}
	return SvPV(*sv, PL_na);
}

static double
get_double(HV *hash, const char *field)
{
	SV **sv = hv_fetch(hash, field, strlen(field), FALSE);
	if(sv == NULL) {
		return 0.0;
	}
	if(!SvOK(*sv)) {
		fprintf(stderr, "Error trying to get 'field'\n", field);
		return 0.0;
	}
	return SvNV(*sv);
}

static long
get_long(HV *hash, const char *field)
{
	SV **sv = hv_fetch(hash, field, strlen(field), FALSE);
	if(sv == NULL) {
		return 0L;
	}
	if(!SvOK(*sv)) {
		fprintf(stderr, "Error trying to get 'field'\n", field);
		return 0L;
	}
	return SvIV(*sv);
}

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

	INIT:
		char *city;
	CODE:
		switch(recid) {
			case ADDRESSES: {
				struct addresses a;

				a.lat = (unsigned long)get_double(buf, "lat");
				a.lon = (unsigned long)get_double(buf, "lon");
				a.number = (unsigned long)get_long(buf, "number");
				strcpy(a.street, get_string(buf, "street"));
				strcpy(a.city, get_string(buf, "city"));
				strcpy(a.county, get_string(buf, "county"));
				strcpy(a.state, get_string(buf, "state"));
				strcpy(a.country, get_string(buf, "country"));

				RETVAL = d_fillnew(recid, &a);
				break;
			}
			default:
				fprintf(stderr, "Unknown recid %lu\n", recid);
				RETVAL = S_INVREC;
		}
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
