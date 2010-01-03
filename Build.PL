use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'aliased',
    license             => 'perl',
    dist_author         => 'Curtis "Ovid" Poe <ovid@cpan.org>',
    dist_version_from   => 'lib/aliased.pm',
    requires => {},
    build_requires => {
        'Test::More' => 0,
    },
    add_to_cleanup      => [ 'aliased-*' ],
    create_makefile_pl  => 'traditional',
);

$builder->create_build_script();
