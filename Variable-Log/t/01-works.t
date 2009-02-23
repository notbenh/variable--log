#!/usr/bin/perl
use strict;
use warnings;

use Test::Most qw{no_plan};

BEGIN {

print "\n" for 1..10;
use_ok( 'Variable::Log' );
can_ok( 'main', qw{
   add_logging
   stop_logging
} );

}; # END BEGIN


my $log_arr  = [];
my $lc_hash  = {};
my $log_code = sub{ my ($event, $value) = @_; push @{ $lc_hash->{$event} }, $value; };

my $value = 10;

dies_ok( sub{ add_logging( '', $value ) }, 'dies if you pass a bad logger');
dies_ok( sub{ add_logging( undef, $value ) }, 'dies if you pass a bad logger');
dies_ok( sub{ add_logging( {}, $value ) }, 'dies if you pass a bad logger');
ok( add_logging( $log_arr , $value ), q{added array logging} );
ok( add_logging( $log_code, $value ), q{added code logging} );

$value ++;

eq_or_diff(
   $log_arr,
   [ q{accessed : 10},
     q{accessed : 10},
     q{set : 11},
   ],
   q{array looks right},
);

eq_or_diff(
   $lc_hash,
   { accessed => [10], set => [11] },
   q{code output looks right},
);

ok( stop_logging($value), q{stop logging} );

eq_or_diff(
   $log_arr,
   [ q{accessed : 10}, #add code loggging
     q{accessed : 10}, #look at $value pre inc
     q{set : 11}, #value set at inc
   ],
   q{array was untouched, stop_logging worked },
);

eq_or_diff(
   $lc_hash,
   { accessed => [10], set => [11] }, #look at $value pre inc and set post inc
   q{code output untouched, stop_logging worked },
);

