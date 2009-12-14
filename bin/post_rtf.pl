#!/usr/bin/perl -pi

s!(.*)\\ql(.*)SMALL_BREAK(.*)!$1\\qc$2#$3!g;
s!(.*)\\ql(.*)BIG_BREAK(.*)!$1\\qc$2* * *$3!g;
s!\\li0 \\fi0!\\li0 \\fi480 \\fs24 \\sl500!g;
s!\\ql(.*)\\fs36!\\qc$1{\\page}\n$1\\fs36!g;

