#!/usr/bin/env perl

use strict;
use warnings;

my $target = "123..45.6789...0";

while ($target =~ /(\d+)/g) {
    print "Saw '$1' ending at position ", pos($target), "\n";
}
