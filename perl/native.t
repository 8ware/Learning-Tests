#! /usr/bin/perl -w

use strict;
use warnings;

use feature 'say';

use Test::More 'no_plan';

#
# This test shows the different behavior of the match-operator in case of a
# print- and in case of a scalar-context.
#
say "g1g2g3" =~ /(g1)g2(g3)/;
my $res = "g1g2g3" =~ /(g1)g2(g3)/;
is(1, $res, "Test behavior of match-operator in print- and scalar context.");

#
# Demonstrate the behavior of the shfit operator in array context
#
say qq/shift operator test:/;
my @list = qw/Hello World its time to learn perl/;
is(@list, 7, 'inital length of the list is seven');
my $singleElement = shift @list;
is($singleElement, 'Hello', 'shifts the first element with index zero');
is(@list, 6, 'after shifting length of list is six');

#
# Test for array-elements given as array-reference are modified by iterating
# them with use of the $_-variable
#
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

