#!/usr/bin/perl -w
use warnings;
use strict;

use Test::More tests => 9;

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

use aliased {
    'base'         => 'Really::Long',
    'modules'      => [qw/PackageName/],
    'Name'         => {},
    'Module::Name' => { alias => 'O::Name', },
};
is $@, '', '... it can use the module with hash and array';
ok defined &main::Name,        '... creates proper functions';
ok defined &main::PackageName, '... creates proper functions';

#warn 'name = '. Name();

my $name = Name->new;
isa_ok $name, 'Really::Long::Name', '... and the object it returns';

my $pname = PackageName->new;
isa_ok $pname, 'Really::Long::PackageName', '... and the object it returns';

use aliased {
    base => 'Really::Long::Module',

    'Conflicting::Name' => {
        alias   => 'C::Name',
        imports => ["echo"],
    }
};

ok defined &main::echo, '... and import items should be handled correctly';
is_deeply [ echo( [ 1, 2 ], 3 ) ], [ [ 1, 2 ], 3 ],
  '... and exhibit the correct behavior';
ok $name = C::Name->new,
'We should be able to alias to different packages, even though that is really stupid';
isa_ok $name, 'Really::Long::Module::Conflicting::Name',
  '... and the object returned';

