package Variable::Log;

use warnings;
use strict;
use Variable::Magic qw{wizard cast dispell};
use Carp qw{croak};

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
use Exporter qw{import};
our @EXPORT = qw{
   add_logging
   stop_logging
};


=head1 FUNCTIONS

=head2 add_logging



=cut

# !! I REALLY HATE THIS
my $__GLOBAL_WIZARD = {};


sub add_logging {
   my ($log, $var) = @_;
   croak sprintf q{%s is not an acceptable type for a logger}, ref($log) || 'undef'
      unless defined $log && ref($log) =~ m/^(CODE|ARRAY)$/;
   croak sprintf q{A variable must be specifed for logging} 
      unless defined $var ;

   #my $wiz = wizard 
   $__GLOBAL_WIZARD = wizard 
      get => sub{ my ($ref, $data) = @_; 
                  return (ref($log) eq 'ARRAY') ? push( @$log, sprintf( q{%s : %s}, 'accessed', $$ref ))
                       : (ref($log) eq 'CODE' ) ? $log->('accessed',$$ref)
                       :                          croak q{Don't know how we got here, but something went bad};
                },
      set => sub{ my ($ref, $data) = @_; 
                  return (ref($log) eq 'ARRAY') ? push( @$log, sprintf( q{%s : %s}, 'set', $$ref ))
                       : (ref($log) eq 'CODE' ) ? $log->('set',$$ref)
                       :                          croak q{Don't know how we got here, but something went bad};
                },
   ;
      
   # you have to cast directly to the input, not the lexical copy
   return cast $_[1], $__GLOBAL_WIZARD ; 
}

=head2 function2

=cut

sub stop_logging {
   # this is overly harsh, though until I work out the best way to store the wizard that is generated in add, we just wipe everything.
   return dispell $_[0], $__GLOBAL_WIZARD;
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
