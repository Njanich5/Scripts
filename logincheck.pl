#!/usr/bin/perl
#/tdc484s04/hw03/hw03script.pl
#Author:Nicholas Janich
#Date: 1/27/2016
#Description: Read /var/log/secure and count how many times a specific IP address fails authentication. Then track its location from Geo:IP:PurePearl
#Usage: hw03script.pl <no args>

$syslog = "/var/log/auth.log"; #file to read
print "Failed Login List \n
 ------------- Intrusion Report ----------------- \n
Count  Country  Region  City            Remote IP \n"; #formatted print
open(FILEREAD, "< $syslog"); #read the file name in syslog
while( <FILEREAD> ) {
        chomp($_); #remove newline
        @data = split(); #split the file by spaces
        if( $data[6] eq "authentication" && $data[7] eq "failure;" ){ #looks for any failed auth attempts
               ($tmp , $ip) = split(/=/, $data[13]); #split the rhost from the IP address given in $data[13]
                $count{$ip}++; #add 1 to count for each occurence of the IP
                }


}
close FILEREAD; #close the file once it finishes reading
use Geo::IP::PurePerl;

$gi = Geo::IP::PurePerl->new( "/usr/share/GeoIP/GeoLiteCity.dat", GEOIP_STANDARD ); #put Geo IP info in #gi
foreach $ip (sort {$count{$b} <=> $count{$a}} (keys %count)) #for each IP sort descending counts
        {
        (  $country_code, $country_code3, $country_name, $region,
           $city,         $postal_code,   $latitude,     $longitude,
           $metro_code,   $area_code) = $gi->get_city_record($ip); #pulls city report info from geo-ip variables and assigns them to each IP
        printf " %-5d   %-2s    %-2s    %-15s   %-15s\n", $count{$ip}, $country_code, $region, $city, $ip;
}

