#!/usr/bin/perl
#Author:Nicholas Janich
#Desc: Script to take problematic IPs found in logincheck.pl and blocks them in iptables.
#Note: Must run as user with sudo privledges

$BadIPs = "BadIPs.txt"; #file to read

print "-------------IPs being added to drop list--------------
\n";
open(FILEREAD, "< $BadIPs"); #read BadIPs.txt
while( <FILEREAD> ) {
        chomp($_); #remove newline
        @data = split(); #split the file by spaces
        foreach $ip(@data) {	#loop to check each IP per line from file
		$check = `sudo iptables -L | grep $ip`;	#checks current iptable config for IPs being read from file
#		print($grep);
#		if( $ip !~ $grep) {
#			print "yes";}
#		else { print "no";}		
		if ($ip !~ $check) {	#checks if IP already exists from grepping iptables 
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

