#!/usr/bin/perl -pi

s/^---/\\brk/g;
s/^\*\*\*/\\bigbrk/g;
s/\\footnote/\\marginpar/g;
#s/\\section/\\chapter/g;

s/\.\.\./\\ldots/g;
