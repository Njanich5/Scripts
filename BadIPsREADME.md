##BadIPs.pl README
This Script can be used as an addition to logincheck.pl, what this script does is finds IP addresses that have multiple failed ssh attempts. It prints the IP address as well as how many failed login attempts that IP has made. This script also outputs these problematic IP addresses to a .txt file called 'BadIPs.txt' this .txt file is mainly used for BlockedIPs.pl.

- This script is currently setup to run on Debian or Ubuntu machines so the log file to read failed usernames is located at `/var/log/auth.log`.
- If you run CentOS/RHEL you will need to change the $see file in line 4 to `/var/log/secure`. For other os types, you will need to change the $see file to wherever failed login attempts are stored.

#### Customize this script
There are a few lines in this script that I put in personally but you may want to exclude.

1. Local IPs excluded
 - In line 26 you will notice a variable I make `$localip = "192.168.1.";` This is mostly to filter out failed ssh attempts I've made from other machines but for security purposes you may want to log all failed ssh connections. To do this either comment out or remove line 26 then go to line 29 and omit `&& $ip != $localip` from the if-statement.

2. Number of failed login attempts to track
 - A big part of this script is setting the number of failed login attempts required to label an IP a Bad IP. I personally set this script to flag any IP that fails 3 or more login attempts as a Bad IP but you can set it to whichever number you want in line 29. Just change the 3 in `if ($count{$ip} >= 3 && $ip != $localip )` to any number.
  
3. Prompt to run BlockIPs.pl
 - I use this script with BlockIPs.pl which takes the problematic IPs and filters them from my firewall but if you don't want to run BlockIPs.pl at the end then either comment out or delete everything after line 40.
  * <i>Note: I you wish to run BlockIPs.pl after BadIps.pl make sure that these scripts are in the same directory and that you are using an account with sudo privleges since BlockIPs.pl uses a few sudo commands. </i>
