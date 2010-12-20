#!/usr/bin/perl -w
use warnings;
use strict;

use Test::More tests => 5;

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

eval {
    use aliased {
        'modules' => [ qw/Really::Long::Name Really::Long::PackageName/ ],
    };
};
is $@, '', '... it can use the module with hash and array';
ok defined &main::Name, '... creates proper functions';
ok defined &main::PackageName, '... creates proper functions';

#warn 'name = '. Name();

my $name = Name->new;
isa_ok $name, 'Really::Long::Name', '... and the object it returns';

my $pname = PackageName->new;
isa_ok $pname, 'Really::Long::PackageName', '... and the object it returns';

