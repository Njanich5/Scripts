#!/usr/bin/perl
#Author: Nicholas Janich

$see = "/var/log/auth.log.1";
print "Successful User Attempt List \n
------------- LOGIN NAMES -------------- \n
Count		Name\n\n";

open(FILEREAD, "< $see");
while(<FILEREAD> ) {
	chomp($_);
	@data = split();
	if( $data[5] eq "Invalid" ) {
	#	printf "$data[7] \n";
		$name = ($data[7]);
	#	$ip = ($data[11]);		
		
		$count{$name}++;
		}

}
close FILEREAD;

foreach $name (sort {$count{$b} <=> $count{$a}} (keys %count)) {
	printf "%-5s		%-5s	%-5s\n", $count{$name}, $name;
}

