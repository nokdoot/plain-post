#!/usr/bin/env perl

use strict;
use warnings;
use Data::Dumper;
use feature qw/ say /;

my @rules = <DATA>;

say @rules;

__DATA__
=podx

hello

=cutx
