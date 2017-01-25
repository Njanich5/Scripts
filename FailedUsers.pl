#!/usr/bin/perl

$see = "/var/log/auth.log";

print "Failed User Attempt List \n
------------- LOGIN NAMES -------------- \n
Count		Name\n\n";
open($output, '>', 'report.txt') or die "Coult not open lognames.txt."; #opens report.txt to write to
open(FILEREAD, "$see");
while(<FILEREAD> ) {
	chomp($_);
	@data = split();
	if( $data[5] eq "Invalid" ) {
	#	printf "$data[7] \n";
		$name = ($data[7]);
	#	$ip = ($data[11]);		
		print $output "$name\n";
		$count{$name}++;
		}

}
system("sort -u report.txt > newrep.txt");
close $output;
close FILEREAD;

foreach $name (sort {$count{$b} <=> $count{$a}} (keys %count)) {
	printf "%-5s		%-5s	%-5s\n", $count{$name}, $name;
}

