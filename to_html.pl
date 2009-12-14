#!/usr/bin/perl -pi

s/\[sc ([^\]]+)\]/'<span style="font-variant:small-caps">' . lc($1) . "<\/span>";/eg;
s/^---/<div style="text-align:center">*<\/div>/g;
