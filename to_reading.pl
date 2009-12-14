#!/usr/bin/perl -pi
s/\[sc ([^\]]+)\]/'\textsc{'.lc($1).'}'/eg;
s/\^d\[([^\]]+)\]//g;
