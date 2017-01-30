#!/usr/bin/perl
#Author:Nicholas Janich
#Desc:  Script to take problematic IPs found in BadIPs.pl and blocks them in iptables.
#	This script reads from a file created by BadIPs.pl, this txt file contains IPs that have failed
#	multiple ssh attempts. The script will then check if the IPs in the txt file already exist in
#	the iptables config and if they don't, it will add a drop rule for ssh connections from that IP
#
#	Note: Must run as user with sudo privledges

$BadIPs = "BadIPs.txt"; #file to read

print "-------------IPs being added to drop list--------------
\n";

open(FILEREAD, "< $BadIPs"); #read BadIPs.txt
while( <FILEREAD> ) {
        chomp($_); #remove newline
        @data = split(); #split the file by spaces
        foreach $ip(@data) {	#loop to check each IP per line from file
		$check = `sudo iptables -L | grep $ip`;	#checks current iptable config for IPs being read from file
		if ($ip !~ $check) {		#checks if IP already exists from grepping iptables 
			print "The IP Address $ip is already being dropped in iptables. \n";
			}

		else {		#if an IP doesn't already exist in current iptables		
			$command = "iptables -A INPUT -s $ip -p 22 -j DROP";	#adds iptable rule to drop incoming ssh connections from the checked IP
			system($command);	#system command to run shell command without storing data
			print "$ip \n"; 	#prints the IP being added to iptables
                }
	}
}
close FILEREAD;

print "
-------------Current iptables configuration-------------- 
\n";	#prints new iptables config after potentially adding IPs
$print_iptables = system('sudo iptables -L');	#system command to run shell command without storing data
print "$print_iptables";

