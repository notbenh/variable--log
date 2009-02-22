package Variable::Log;

use warnings;
use strict;
use Variable::Magic qw{wizard cast dispell};
use Carp::Assert::More;

=head1 NAME

Variable::Log - The great new Variable::Log!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use Variable::Log;

    my $foo = Variable::Log->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=cut

use constant SCALARVARIABLELOGGER = wizard 
           sig      => ...,
           data     => sub { ... },
           get      => sub { my ($ref, $data [, $op]) = @_; ... },
           set      => sub { my ($ref, $data [, $op]) = @_; ... },
           len      => sub { my ($ref, $data, $len [, $op]) = @_; ... ; return $newlen; },
           clear    => sub { my ($ref, $data [, $op]) = @_; ... },
           free     => sub { my ($ref, $data [, $op]) = @_, ... },
           copy     => sub { my ($ref, $data, $key, $elt [, $op]) = @_; ... },
           local    => sub { my ($ref, $data [, $op]) = @_; ... },
           fetch    => sub { my ($ref, $data, $key [, $op]) = @_; ... },
           store    => sub { my ($ref, $data, $key [, $op]) = @_; ... },
           exists   => sub { my ($ref, $data, $key [, $op]) = @_; ... },
           delete   => sub { my ($ref, $data, $key [, $op]) = @_; ... },
           copy_key => $bool,
           op_info  => [ 0 | VMG_OP_INFO_NAME | VMG_OP_INFO_OBJECT ]
;

use constant CODEREFVARIABLELOGGER = wizard 
           get      => sub { my ($ref, $data [, $op]) = @_; ... },
           set      => sub { my ($ref, $data [, $op]) = @_; ... },
;

use constant ARRAYVARIABLELOGGER = wizard 
           get      => sub { my ($ref, $data [, $op]) = @_; ... },
           set      => sub { my ($ref, $data [, $op]) = @_; ... },
;

=head1 FUNCTIONS

=head2 add_logging



=cut

sub add_logging {
   my ($var, $log) = @_;
   assert_defined( $var );
   assert_defined( $log );
   assert_like(ref($log),qr/^(CODE|ARRAY|)$/, sprintf q{ %s is not an acceptable type for a logger}, ref($log) );
   
   # pick the right logger based on the the type of $log
   return cast $var, (ref($log) eq 'ARRAY') ? ARRAYVARIABLELOGGER
                   : (ref($log) eq 'CODE')  ? CODEVARIABLELOGGER
                   :                          SCALARVARIABLELOGGER ;
}

=head2 function2

=cut

sub function2 {
}

=head1 AUTHOR

Ben Hengst, C<< <NOTBENH at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-variable-log at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Variable-Log>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Variable::Log


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Variable-Log>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Variable-Log>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Variable-Log>

=item * Search CPAN

L<http://search.cpan.org/dist/Variable-Log/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 COPYRIGHT & LICENSE

Copyright 2009 Ben Hengst, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.


=cut

1; # End of Variable::Log
