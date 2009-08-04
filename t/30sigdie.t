#!/usr/bin/perl -w
use warnings;
use strict;

use lib "t/lib";

BEGIN {
    # Ensure nothing else has loaded a $SIG{__DIE__}
    die if $SIG{__DIE__};
}

# Test::Builder might have a $SIG{__DIE__}, too so we
# make sure it is effected by any aliased bug, too.
use aliased "Test::More";
use aliased "HasSigDie";

plan(tests => 2);

is ref $SIG{__DIE__}, "CODE",
  '$SIG{__DIE__} handlers should not be destroyed';

is $SIG{__DIE__}->(), 'whee!',
  '... and should behave as expected';
