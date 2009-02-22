use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Variable::Log',
    license             => 'perl',
    dist_author         => 'Ben Hengst <NOTBENH@cpan.org>',
    dist_version_from   => 'lib/Variable/Log.pm',
    build_requires => {
        'Test::More' => 0,
    },
    add_to_cleanup      => [ 'Variable-Log-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
