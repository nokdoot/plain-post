package Lexer;

use strict;
use warnings;

use Constant qw/ SPACE EMPTY_LINE NEW_LINE EOF COMMAND WORD ERR /;

sub token_stream {
    my $fh = shift;
    my $line = undef;
    my $line_number = 0;
    return sub { 
        my $pos = pos($line);
        if (!$line or !$pos or length($line) == $pos) {
            $line = readline($fh);
            $line_number++;
        }

        return [EOF, undef] if !defined $line;
        return [EMPTY_LINE, undef] if $line =~ /\G ^\s*$  /gcx;
        return [NEW_LINE, $1] if $line =~ /\G (\n) /gcx;
        return [SPACE, $1] if $line =~ /\G (\s+) /gcx;
        return [COMMAND, $1] if $line =~ /\G (^=) /gcx;
        return [WORD, $1] if $line =~ /\G ([\p{L}\p{N},]+) /gcxu;
        return [ERR, $line, "line number $line_number", 'at '.($pos+1)];
    }
}

1;
