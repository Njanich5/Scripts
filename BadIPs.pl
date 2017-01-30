#!/usr/bin/perl
#/tdc484s04/hw03/hw03script.pl
#Author:Nicholas Janich

#remove duplicates

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

	
