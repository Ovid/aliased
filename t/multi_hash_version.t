#!/usr/bin/perl -w
use warnings;
use strict;

use Test::More tests => 3;

#
# Testing the form:
#
# use aliased {
#   'Some::Base::Pkg' => [ qw/Mod1 Mod2 Mod3/ ]
# };
#

BEGIN {
    chdir 't' if -d 't';
    unshift @INC => '../lib', 'lib/';
}

eval qq( use aliased { 'Really::Long::Name' => { version => 4.50 } } );
#diag( $@);
ok $@, '... cannot alias with a non-existent minimum version of a module';
like $@, qr/version\s+\S+\s+required/, '... with a proper error message';

eval qq(
    use aliased {
        'Really::Long::Name' => {
            version => 0.50
        }
    };
);
is $@, '', '.. can alias with a valid version number ['.$@.']';

