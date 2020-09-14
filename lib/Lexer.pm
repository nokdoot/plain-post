package Lexer;

use strict;
use warnings;

sub line_stream {
    my $fh = shift;
    return sub { return scalar (readline $fh) };
}

sub read_line {
    my $fh = shift;
    return readline $fh;
}

sub tokenizer {
    FINDING: {
        redo FINDING            
            if $line =~ /\G (s+) /gcx;

        return ['HTML_H1', $1]  
            if $line =~ /\G (^ =head1 \n* | \n+) /gcx;

        return ['HTML_H2', $1]  
            if $line =~ /\G (^ =head2 \n* | \n+) /gcx;

        return ['UNKNOWN', $1, pos($line)]   
            if $line =~ /\G (.*) /gcx; 
    }
}

sub next_token {
    my $fh = shift;

    my $line = '';

    return sub {
        if (!$line) {
            $line = read_line($fh);
        }
        return $line;
    };

#     my $line = shift;
#     return sub {
#     };
}

1;
