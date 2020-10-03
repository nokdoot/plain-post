#!/usr/bin/env perl

use strict;
use warnings;

use feature qw/ say /;

my $line = 'asasasasas';

$line =~ m/^as/g;
my $a = pos($line);
say $a;
$line =~ m/^as/g;
 $a = pos($line);
say $a;
$line =~ m/^as/g;
 $a = pos($line);
say $a;
