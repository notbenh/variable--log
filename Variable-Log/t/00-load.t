#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'Variable::Log' );
}

diag( "Testing Variable::Log $Variable::Log::VERSION, Perl $], $^X" );
