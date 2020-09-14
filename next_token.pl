#!/usr/bin/env perl

use strict;
use warnings;
use feature qw/ say /;


sub next_token {
    my $line = shift;
    return sub {
        FINDING: {
            redo FINDING            if $line =~ /\G (s+)                 /gcx;
            return ['HTML_H1', $1]  if $line =~ /\G (^ =head1 \n* | \n+) /gcx;
            return ['HTML_H2', $1]  if $line =~ /\G (^ =head2 \n* | \n+) /gcx;
            return ['UNKNOWN', $1, pos($line)]   if $line =~ /\G (.*)                  /gcx; 
        }
    };
}

my $lise = <DATA>;
my $f = next_token($lise);
say "@{$f->()}";

__DATA__
=headaaaa1

=head2
