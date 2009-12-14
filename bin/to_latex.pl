#!/usr/bin/perl -pi

s/^---/\\brk/g;
s/^\*\*\*/\\bigbrk/g;
s/\\section/\\chapter/g;
s/\^d\[([^\]]+)\]//g;
#s/\\maketitle/\\thispagestyle\{empty\}/g;
