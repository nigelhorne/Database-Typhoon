# Before 'make install' is performed this script should be runnable with
# 'make test'. After 'make install' it should work as 'perl Database-Typhoon.t'

#########################


use strict;
use warnings;

use Test::Most tests => 5;

use constant S_OKAY => 0; # Operation successful
use constant S_INVDB => 1000; # Invalid database

BEGIN { use_ok('Database::Typhoon') };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

is(Database::Typhoon::dt_d_open("foo", "s"), S_INVDB);
is(Database::Typhoon::dt_d_dbdpath('../../osdb-typhoon/examples'), S_OKAY);
is(Database::Typhoon::dt_d_dbfpath('../../osdb-typhoon/examples'), S_OKAY);
is(Database::Typhoon::dt_d_open("demo", "x"), S_OKAY);
