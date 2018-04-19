# Before 'make install' is performed this script should be runnable with
# 'make test'. After 'make install' it should work as 'perl Database-Typhoon.t'

#########################

use strict;
use warnings;

use Test::Most tests => 8;

use constant S_OKAY => 0; # Operation successful
use constant S_NOTFOUND => 1; #* Key not found
use constant S_DUPLICATE => 2; # Duplicate key found
use constant S_INVDB => 1000; # Invalid database
use constant ADDRESSES => 1000;
use constant ALL => 0;

BEGIN { use_ok('Database::Typhoon') };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

is(Database::Typhoon::d_open("foo", "s"), S_INVDB);
is(Database::Typhoon::d_dbdpath('examples'), S_OKAY);
is(Database::Typhoon::d_dbfpath('examples'), S_OKAY);
is(Database::Typhoon::d_open("openaddresses", "s"), S_OKAY);

while(Database::Typhoon::d_keyfrst(ALL) == S_OKAY) {
	Database::Typhoon::d_delete();
}

my $record = {
	'lat' => 38.99516556,
	'lon' => -77.09943963,
	'street' => 'MEDLARS DR',
	'city' => 'BETHESDA',
	'county' => 'MONTGOMERY',
	'postcode' => 20894,
};

is(Database::Typhoon::d_fillnew(ADDRESSES, $record), S_OKAY);
is(Database::Typhoon::d_fillnew(ADDRESSES, $record), S_DUPLICATE);
is(Database::Typhoon::d_fillnew(ADDRESSES, $record), S_DUPLICATE);
