#!/usr/bin/perl
#Author: Nicholas Janich

$see = "/var/log/auth.log"; 	#ssh log file, where failed usernames are stored on Debain/Ubuntu
print "Failed User Attempt List \n 
------------- LOGIN NAMES -------------- \n
Count		Name\n\n";		#formatted print to look pretty, adds 

open(FILEREAD, "< $see");	#opens filehandler to read ssh logs
while(<FILEREAD> ) {		#while reading from file
	chomp($_);		#removes new line characters
	@data = split();	#splits data to be read
	if( $data[5] eq "Invalid" ) {		#checks if 6th word reads 'Invalid', this is how failed attempts are found
		$name = ($data[7]); 	#8th word in failed login attempts contains the username that was tried, this sets the failed username to the $name value
		$count{$name}++;	#for each unique username, adds 1 to a counter to find total times that username was used
		}

}
close FILEREAD;		#closes filehandler

foreach $name (sort {$count{$b} <=> $count{$a}} (keys %count)) {	#foreach username sort counts in descending order
	printf "%-5s		%-5s	%-5s\n", $count{$name}, $name;	#formatted print to show usernames and total count
}

