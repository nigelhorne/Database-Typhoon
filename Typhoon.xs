// #define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include "typhoon.h"
#include "examples/openaddresses.h"

static const char *
get_string(HV *hash, const char *key)
{
	SV **sv = hv_fetch(hash, key, strlen(key), FALSE);
	if(sv == NULL) {
		/* fprintf(stderr, "Error trying to get '%s'\n", key); */
		return NULL;
	}
	if(!SvOK(*sv)) {
		fprintf(stderr, "Error trying to get '%s'\n", key);
		return NULL;
	}
	return SvPV(*sv, PL_na);
}

static SV **
set_string(HV *hash, const char *key, const char *val)
{
	SV *sv = newSVpv(val, strlen(val));
	SV **rc;

	rc = hv_store(hash, key, strlen(key), sv, 0L);
	if(rc == NULL) {
		fprintf(stderr, "Error trying to set '%s'\n", key);
		return NULL;
	}
	if(!SvOK(*rc)) {
		fprintf(stderr, "Error trying to set '%s'\n", key);
		return NULL;
	}
	return rc;
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

static SV **
set_double(HV *hash, const char *key, double val)
{
	SV *sv = newSVnv(val);
	SV **rc;

	rc = hv_store(hash, key, strlen(key), sv, 0L);
	if(rc == NULL) {
		fprintf(stderr, "Error trying to set '%s'\n", key);
		return NULL;
	}
	if(!SvOK(*rc)) {
		fprintf(stderr, "Error trying to set '%s'\n", key);
		return NULL;
	}
	return rc;
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

static SV **
set_long(HV *hash, const char *key, long val)
{
	SV *sv = newSVnv(val);
	SV **rc;

	rc = hv_store(hash, key, strlen(key), sv, 0L);
	if(rc == NULL) {
		fprintf(stderr, "Error trying to set '%s'\n", key);
		return NULL;
	}
	if(!SvOK(*rc)) {
		fprintf(stderr, "Error trying to set '%s'\n", key);
		return NULL;
	}
	return rc;
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
	CODE:
		switch(recid) {
			case ADDRESSES: {
				struct addresses a;

				a.lat = (double)get_double(buf, "lat");
				a.lon = (double)get_double(buf, "lon");
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

 # Note extra argument: recid
int
d_recread(recid, buf)
	unsigned long recid
	HV *buf;
	CODE:
		switch(recid) {
			case ADDRESSES: {
				struct addresses a;

				RETVAL = d_recread(&a);
				/*
				 * TODO:
				 *	Use hv_store to copy the fields
				 *	from a into buf
				 */
				if(buf == NULL) {
					buf = newHV();
				}
				set_double(buf, "lat", a.lat);
				set_double(buf, "lon", a.lon);
				set_long(buf, "number", a.number);
				set_string(buf, "street", a.street);
				set_string(buf, "city", a.city);
				set_string(buf, "county", a.county);
				set_string(buf, "state", a.state);
				set_string(buf, "country", a.country);
				break;
			}
			default:
				fprintf(stderr, "Unknown recid %lu\n", recid);
				RETVAL = S_INVREC;
		}
	OUTPUT:
		RETVAL
