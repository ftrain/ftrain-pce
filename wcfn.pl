#!/usr/bin/perl

$base=250;
$wpm=$base;
while (<>) {
    for (split) {
        $base_count++;        
    }
    push @lines, $_;
}

print STDERR $base_count;
for (@lines) {
    $x=0;$y=0;
    s/\^d\[([^\]]+)\]/$h{$x++}=$1;'__PARSE_ME__';/eg;
    
    $line = '';
    for (split) {
        $count++;
        $line .= $_;
        $line .= " ";
        $line .= '\marginpar{' 
            . wcfn($count) . 'w\linebreak' 
            . int($count/$wpm)
            .'/'
            . int($base_count/$wpm) 
            .'m\linebreak'
            . sprintf("%01d",(100*$count/$base_count)).'\%}' 
            unless ($count % $base);
    }
    $line =~ s/__PARSE_ME__/direct($h{$y++})/eg;
    push @newlines, $line;
}

for (@newlines) {
    print;
    print "\n";
}

sub direct {
    local $_  = shift;
    return '\direction{'.uc($_).'}';
}
sub wcfn {
    local $_  = shift;
    1 while s/^([‐+]?\d+)(\d{3})/$1,$2/;
    return $_;
}
