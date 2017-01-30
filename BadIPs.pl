#!/usr/bin/perl
#/tdc484s04/hw03/hw03script.pl
#Author:Nicholas Janich
#Desc: Script to read from failed ssh attempts and create a txt file that lists IPs that have failed to connect,
#	and how many times they have tried to connect. I also made this script exclude local IPs that failed to 
#	connect but you can change that functionality by modifying 2 lines as explained in the README.
#	
#	I added a prompt to run another script at the end called BlockIPs.pl. BlockIPs.pl takes the problematic
#	IPs found from this script and will add them to be blocked from iptables. Please See the BlockIPsREADME
#	for more information on how it works.
#
$syslog = "/var/log/auth.log"; #file to read
print "
-------------Problematic IP List ----------------- \n
Count	Remote IP \n"; #formatted print
open(FILEREAD, "< $syslog"); #read the file name in syslog
while( <FILEREAD> ) {
        chomp($_); #remove newline
        @data = split(); #split the file by spaces
        if( $data[6] eq "authentication" && $data[7] eq "failure;" ){ #looks for any failed auth attempts
               ($tmp , $ip) = split(/=/, $data[13]); #split the rhost from the IP address given in $data[13]
                $count{$ip}++; #add 1 to count for each occurence of the IP
                }
}

$file = 'BadIPs.txt'; #local txt file to save bad IPs
$localip = "192.168.1."; 
open($fh, '>', $file) or die "Could not open file '$file' $!"; #open filehandler, append to this file or close
foreach $ip (sort{$count{$b} <=> $count{$a}}(keys %count)) { #foreach IP sort descending counts
	if ($count{$ip} >= 3 && $ip != $localip ) { #look for IPs that occur more than 3 times, also do not include local IPs that appear in ssh logs
		$fh->print($ip . "\n"); #filehandler prints each problematic IP followed by a new line
		printf "%-5d	%-15s\n", $count{$ip}, $ip; #formatted print for count and IPs
		}
	}

#close both filehandlers
close $fh; 
close FILEREAD;

#This code below asks if you would like to run an additional script to block the IPs found
print "
Would you like to run BlockIPs.pl and block these IPs found above? (y/n) ";
chomp($blockprompt = <STDIN>);		#variable to store user entry
if ($blockprompt eq "n" || $blockprompt eq "no" || $blockprompt eq "N" || $blockprompt eq "") {
	exit;		#if user enters no, n, N or null, exit the script
	}
else { 
	if ($blockprompt eq "y" || $blockprompt eq "yes" || $blockprompt eq "Y") {	#if user enters yes, y, or Y then run BlockIPs.pl
		print("Running BlockIPs.pl.................................... \n");
		system('sudo perl BlockIPs.pl');	#system call to run BlockIPs in shell, must have sudo privleges
		}
		 
 }
	
