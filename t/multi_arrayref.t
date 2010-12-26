#!/usr/bin/perl -w
use warnings;
use strict;

use Test::More tests => 8;

# Testing the form:
#
# use aliased 'Some::Base::Pkg' => [ qw/Mod1 Mod2 Mod3/ ]

BEGIN {
    chdir 't' if -d 't';
    unshift @INC => '../lib', 'lib/';
    use_ok 'aliased', 'Really::Long' => [ qw/Name PackageName/ ];
}
ok defined &main::Name, '... creates proper functions';
ok defined &main::PackageName, '... creates proper functions';

my $name = Name->new;
isa_ok $name, 'Really::Long::Name', '... and the object it returns';

my $pname = PackageName->new;
isa_ok $pname, 'Really::Long::PackageName', '... and the object it returns';

eval q{ use aliased Really::Long::Module::Name => { must => 'blow' } };
ok $@, 'a hash reference as 2nd param, this will not do!!';

use aliased 'Really::Long::Module::Conflicting::Name' => 'C::Name', "echo";
ok $name = C::Name->new,
'We should be able to alias to different packages, even though that is really stupid';
isa_ok $name, 'Really::Long::Module::Conflicting::Name',
  '... and the object returned';

