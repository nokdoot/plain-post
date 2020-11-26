#!/usr/bin/env perl

=pod

3+5 와 같은 한 자리수 덧셈만 가능한 interpreter

=cut

use strict;
use warnings;
use feature qw/ say /;
use Data::Dumper;

use constant INTEGER => 'INTEGER';
use constant PLUS => 'PLUS';
use constant EOF => 'EOF';

use Carp;

package Token {
    sub new {
        my ($class, $type, $value) = @_;
        my $self = {
            type => $type,
            value => $value,
        };
        bless $self, $class;
        return $self;
    }

    sub str {
        my $self = shift;
        return "Token($self->{type}, $self->{value})";
    }
}

package Lexer {
    sub new {
        my ($lass, $text) = @_;
        my $pos = 0;
        return bless {
            text => $text,
            pos => $pos,
            current_char => substr($text, $pos, 1);
        }, $class;
    }

    sub error {
        my $self = shift;
        main::confess "Lexer Error on $self";
    }

    sub advance {
        $self->{pos}++;
        my $pos = $self->{pos};
        if ($pos > length($self->{text}) - 1) {
            $self->{current_char} = undef;
        }
        else {
            $self->{current_char} = substr($self->{text}, $pos, 1);
        }
    }
}

package Interpreter {
    sub new {
        my ($class, $text) = @_;
        my $self = {
            text => $text,
            pos => 0,
            current_token => undef
        };
        bless $self, $class;
        return $self;
    }

    sub error {
        my $self = shift;
        main::confess "We're outta here!";
    }

    sub get_next_token {
        my $self = shift;
        my $text = $self->{text};

        if ($self->{pos} > length($text) - 1) {
            return Token->new(main::EOF, undef);
        }

        my $current_char = substr($text, $self->{pos}, 1);

        if ($current_char =~ qr/ ^ [[:digit:]]+ $ /x) {
            my $token = Token->new(main::INTEGER, $current_char);
            $self->{pos}++;
            return $token;
        }

        if ($current_char eq '+') {
            my $token = Token->new(main::PLUS, $current_char);
            $self->{pos}++;
            return $token;
        }

        $self->error;
    }

    sub eat {
        my ($self, $token_type) = @_;
        if ($self->{current_token}->{type} eq $token_type) {
            $self->{current_token} = $self->get_next_token;
        }
        else {
            $self->error
        }
    }

    sub expr {
        my $self = shift;
        $self->{current_token} = $self->get_next_token;
        my $left = $self->{current_token};

        $self->eat(main::INTEGER);
        my $op = $self->{current_token};

        $self->eat(main::PLUS);
        my $right = $self->{current_token};

        $self->eat(main::INTEGER);

        my $result = $left->{value} + $right->{value};
        return $result;
    }
}

while (<>) {
    chop($_);
    my $line = $_;
    if (!$line) {
        next;
    }
    my $interpreter = Interpreter->new($line);
    my $result = $interpreter->expr;
    say $result;
}
