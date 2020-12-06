#!/usr/bin/perl -w
use strict;
use Switch;

my (@start, @end, @name);
my $i = 0;

open FILE,  "<", "Blocks.txt" or die "$!";
while (<FILE>) {
    chomp;
    if (m/^([0-9a-fA-F]+)\.\.([0-9a-fA-F]+);\s+(.+)$/) {
		$start[$i] = hex($1);
		$end[$i] = hex($2);
		$name[$i++] = $3;
    }
}
close FILE;

my $numi = $i;

open FILE,  "<", "UnicodeData.txt" or die "$!";
my @alloced; my @desc;
while (<FILE>) {
    if (/^([0-9A-F]{4,5});/) {
		my $this = $1;
		if (!/<control>/ && !/surrogate/i && !/private use/i) {
			my @data = split(';', $_);
			push @alloced, hex($this);
			$desc[hex($this)] = $data[1];
		}
    }
}
close FILE;

my $first = 0; my $last = 0; my $inrange = 0;
$i = 0;
printf "// %04X..%04X; %s\n", $start[$i], $end[$i], $name[$i];
foreach my $entry (@alloced) {
    if ($entry <= $end[$i] && !($desc[$entry] =~ /, First/) && $entry == $last+1 || $desc[$entry] =~ /, Last/) {
		# There was not a hole and we're still in the block
		if (!$inrange) {
			$first = $last;
		}
		$inrange = 1;
		$last = $entry;
    } else {
		if ($inrange || $entry > $end[$i]) {
			if ($last-$first > 2) {
				printf "\tc = 0x%x;\t\t// from %s\n", $first, $desc[$first];
				printf "\twhile (c <= 0x%x)\t// ..to %s\n", $last, $desc[$last];
				print "\t\tcharset[i++] = c++;\n";
			} else {
				printf "\tcharset[i++] = 0x%x;\t// %s\n", $first, $desc[$first];
				if ($last != $first) {
					printf "\tcharset[i++] = 0x%x;\t// %s\n", $last, $desc[$last];
				}
			}
			$first = $entry;
			$inrange = 0;
		}
		if ($entry > $end[$i]) {
			++$i;
			printf "// %04X..%04X; %s\n", $start[$i], $end[$i], $name[$i];
			while ($entry > $end[$i]) {
				++$i;
				printf "// %04X..%04X; %s\n", $start[$i], $end[$i], $name[$i];
			}
		}
		$last = $entry;
    }
}

while (++$i < $numi) {
    printf "// %04X..%04X; %s\n", $start[$i], $end[$i], $name[$i];
}
