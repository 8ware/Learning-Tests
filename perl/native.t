#! /usr/bin/perl -w

use strict;
use warnings;

use feature 'say';

use Test::More 'no_plan';

=pod

=head1 NAME

Lerning tests - native perl

=head1 DESCRIPTION

some description goes here...

=head1 TEST-CASES

=cut

#
# This test shows the different behavior of the match-operator in case of a
# print- and in case of a scalar-context.
#
say "g1g2g3" =~ /(g1)g2(g3)/;
my $res = "g1g2g3" =~ /(g1)g2(g3)/;
is(1, $res, "Test behavior of match-operator in print- and scalar context.");

#
# Demonstrate the behavior of the shfit operator 
#
say '==== The shift operator '.('=' x 15);
my @list = qw/Hello World its time to learn perl/;
is(@list, 7, 'inital length of the list is seven');
my $singleElement = shift @list;
is($singleElement, 'Hello', 'shifts the first element with index zero');
is(@list, 6, 'after shifting length of list is six');

#
# Test for array-elements given as array-reference are modified by iterating
# them with use of the $_-variable
#
say '==== manipulate array references with $_ '.('=' x 15);
sub modify(\@) {
	my $strings = shift;
	for(@{$strings}) {
		$_ = substr $_, 0, 1;
	}
};
my @strings = qw(aaa bb);
modify @strings;
is_deeply(\@strings, ['a', 'b'], "after modification of the string-array "
		."the items should be trimmed to length 1");

#
# Shows how shift works in an array context.
#
say '==== Shift in array context  '.('=' x 15);
my @array = (1 .. 5);
my @endpart = ();

is($array[0], 1, "first element is one");
push(@array,shift @array);
is($array[0], 2, "first element is two now");

@endpart = shift @array;
@endpart = shift @array;
is(@endpart,1, "this array has just one element");

=head2 Array-ranges with slices

Test the extraction of ranges from an array with slices. The extraction is
performed by the indication of a range: @array[$i .. $j]

=cut
my @array = qw(a b c d e f);
my($i, $j) = qw(2 4);
is_deeply([@array[$i .. $j]], ['c', 'd', 'e'], "Extraction should deliver 'c' to 'e'.");


=head2 A special from of subroutine the B<AUTOLOAD> routine

The Autoload subroutine is loaded when the called subroutine is not defined.
The I<$AUTOLOAD> variable gets the fully qualified name of the called subroutine.
To get the value in I<$AUTOLOAD> it is necessary to write the full qualified name too.

=cut

AUTOLOAD {
 $_ = $::AUTOLOAD;
 s/.*:://;
 return $_;
}

sub equal($);

=pod

The called subroutine in this example exists but is not defined.
To define a subroutine they need a body.

=cut

my $retvalue = &equal;
ok(!defined &equal, qq/The equal subroutine is not defined because she has no body/);
ok(exists  &equal, qq/the equal subroutine are exists because it has a prototype/);
ok($retvalue eq "equal", qq/right name was returned/);
is(prototype &equal, q/$/, qq/if the subroutine were defined, they would expect one skalar parameter/);

