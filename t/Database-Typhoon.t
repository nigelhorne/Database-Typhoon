# Before 'make install' is performed this script should be runnable with
# 'make test'. After 'make install' it should work as 'perl Database-Typhoon.t'

#########################

use strict;
use warnings;

use Test::Most tests => 19;

BEGIN { use_ok('Database::Typhoon', ':all') };

use constant ADDRESSES => 1000;
use constant ALL => 0;

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

is(Database::Typhoon::d_open("foo", "s"), S_INVDB);
is(Database::Typhoon::d_dbdpath('examples'), Database::Typhoon::S_OKAY);
is(Database::Typhoon::d_dbfpath('examples'), S_OKAY);
is(Database::Typhoon::d_open("openaddresses", "s"), S_OKAY);

while(Database::Typhoon::d_keyfrst(ALL) == S_OKAY) {
	Database::Typhoon::d_delete();
}

my $record = {
	'lat' => 38.99516556,
	'lon' => -77.09943963,
	'number' => 0,
	'street' => 'MEDLARS DR',
	'city' => 'BETHESDA',
	'county' => 'MONTGOMERY',
	'state' => 'MD',
	'country' => 'US',
	'postcode' => 20894,
};

is(Database::Typhoon::d_fillnew(ADDRESSES, $record), S_OKAY);
is(Database::Typhoon::d_fillnew(ADDRESSES, $record), S_DUPLICATE);
is(Database::Typhoon::d_fillnew(ADDRESSES, $record), S_DUPLICATE);
is(Database::Typhoon::d_keyfrst(ALL), S_OKAY);
my $rc = {};
is(Database::Typhoon::d_recread(ADDRESSES, $rc), S_OKAY);
# diag(Data::Dumper->new([$rc])->Dump());
ok($rc->{'lat'} == 38.99516556);
ok($rc->{'street'} eq 'MEDLARS DR');
is(Database::Typhoon::d_delete(), S_OKAY);
is(Database::Typhoon::d_keyfrst(ALL), S_NOTFOUND);
is(Database::Typhoon::d_fillnew(ADDRESSES, $record), S_OKAY);
is(Database::Typhoon::d_keyfrst(ALL), S_OKAY);
is(Database::Typhoon::d_delete(), S_OKAY);
is(Database::Typhoon::d_keyfrst(ALL), S_NOTFOUND);
is(Database::Typhoon::d_close(), S_OKAY);
