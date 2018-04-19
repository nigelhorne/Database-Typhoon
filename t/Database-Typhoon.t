# Before 'make install' is performed this script should be runnable with
# 'make test'. After 'make install' it should work as 'perl Database-Typhoon.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use strict;
use warnings;

use Test::Most tests => 2;

use constant S_OKAY => 0;

BEGIN { use_ok('Database::Typhoon') };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

isnt(Database::Typhoon::dt_d_open("foo", "s"), S_OKAY);
