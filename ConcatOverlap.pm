#!/usr/bin/env perl 
#===============================================================================
#
#        Package ConcatOverlap
#
#  DESCRIPTION: defines concat_overlap($a, $b, $between)
#               which concatenates strings $a and $b
#               taking avoiding an overlap
#               at the end of $a and the beginning of $b
#
#               If $between is given, it is inserted if $a and $b do
#               NOT overlap.
#
#       AUTHOR: Bernhard Fisseni (bfi), bernhard.fisseni@uni-due.de
# ORGANIZATION: Uni Duisburg-Essen
#      VERSION: 1.0
#      CREATED: 2015-12-07, 13:26:51 (CET)
#     REVISION: ---
#  Last Change: 2015-12-07, 14:47:28 CET
#===============================================================================

use utf8;
use feature qw(say state switch unicode_strings);
use re "/u";
use autodie;
use v5.14;
require Exporter;
my @ISA = qw(Exporter);
my @EXPORT_OK = qw(concat_overlap);


sub concat_overlap{
    my ($a, $b, $between) = @_;
    my $last = 0;
    my $la = length($a);
    my $lb = length($b);
    if ($la == 0){
        return $b
    } elsif ($lb == 0){
        return $a;
    } else {
        my $min = ($la > $lb) ? $lb : $la;
        LOOP: for (my $i = $min; $i > 0; $i--){
            for (my $j = $i; $j >0; $j--){
                my $left_suffix = substr($a, $la - $j);
                my $right_prefix = substr($b, 0, $j);
                if ($left_suffix eq $right_prefix){
                    return $a . substr($b, $j);
                }
            }

        }
    }
    return $a . ($between // "") . $b;
}

# say concat_overlap("abcdef", "defg");  # "abcdefg"
# say concat_overlap("abcd", "defg");    # "abcdefg"
# say concat_overlap("abc", "defg");     # "abcdefg"
# say concat_overlap("abcd", "defg");    # "abcdefg"
# say concat_overlap("abcdx", "defg");   # "abcdxdef"

1;
