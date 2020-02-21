## logincheck.pl 
logincheck.pl is a Linux/Unix script I made that checks for failed ssh login attempts, tracks which country and IP these failed attempts came from, and counts how many times each IP has tried to login. Before you try running logincheck.pl there are a few things you'll need to check and setup to make sure it works. 

<b>STEP 1 - Your log file</b><br>
- This script is currently setup to run on Debian or Ubuntu machines so the log file to read failed login attempts is located at `/var/log/auth.log` in line 8. 
- If you run CentOS/RHEL you will need to change the $syslog file to `/var/log/secure`. For other os types, you will need to change the $syslog variable to wherever failed ssh attempts are stored.


<b>STEP 2 - Install Geo::IP::PurePerl</b><br>
- A simple guide on how to install the Geo::IP::PurePerl module using CPAN can be found here: https://www.garron.me/en/bits/install-geoip-cpan-ubuntu.html

* *NOTE: After the last step in that guide you will need to additionally install PurePerl so after you install Geo::IP make sure you also install PurePerl with `install Geo::IP::PurePerl` 


<b>STEP 3 - Download GeoLiteCity database</b><br>
- Now to download the GeoLiteCity database type `wget -N http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz`

- Once you finish downloading the database we will need to unzip the file, to do this type `gunzip GeoLiteCity.dat.gz`

- Next, to install the database you will need to locate where your PurePerl module resides. A simple `locate PurePerl.pm` command should give you a path like `/usr/local/share/perl/5.18.2/Geo/IP/PurePerl.pm`
on ubuntu. If locate doesn't give you a file path run this command `sudo updatedb`. Once you locate the right path, copy it as we will use it later to tell the script where to read the GeoLiteCity database file.

- After you find the path we will then move the database into the same folder that your PurePerl module is located so on my ubuntu machine my command would look like this `sudo mv GeoLiteCity.dat /usr/local/share/perl/5.18.2/Geo/IP/` since this was the folder I found when I ran the previous locate command.

- Now edit the logincheck.pl script with a text editor of choice and change the filepath in line 25 to the path we copied before and add GeoLiteCity.dat to the end of the path. So my filepath in line 26 looks like this `/usr/local/share/perl/5.18.2/Geo/IP/GeoLiteCity.dat` Write and quit to save these changes once your filepath matches the one we found from our locate command.

- Once these steps are properly completed you should be all set to run logincheck.pl
---------------------------------------------------------------------------------------------------------------------------------------------------

## BadIPs.pl
This Script can be used as an addition to logincheck.pl, what this script does is finds IP addresses that have multiple failed ssh attempts. It prints the IP address as well as how many failed login attempts that IP has made. This script also outputs these problematic IP addresses to a .txt file called 'BadIPs.txt' this .txt file is mainly used for FilterIPs.pl.

- This script is currently setup to run on Debian or Ubuntu machines so the log file to read failed usernames is located at `/var/log/auth.log`.
- If you run CentOS/RHEL you will need to change the $see file in line 4 to `/var/log/secure`. For other os types, you will need to change the $see file to wherever failed login attempts are stored.

#### Customize this script
There are a few lines in this script that I put in personally but you may want to exclude.

1. Local IPs excluded
 - In line 26 you will notice a variable I make `$localip = "192.168.1.";` This is mostly to filter out failed ssh attempts I've made from other machines but for security purposes you may want to log all failed ssh connections. To do this either comment out or remove line 26 then go to line 29 and omit `&& $ip != $localip` from the if-statement.

2. Number of failed login attempts to track
 - A big part of this script is setting the number of failed login attempts required to label an IP a Bad IP. I personally set this script to flag any IP that fails 3 or more login attempts as a Bad IP but you can set it to whichever number you want in line 29. Just change the 3 in `if ($count{$ip} >= 3 && $ip != $localip )` to any number.
  
3. Prompt to run FilterIPs.pl
 - I use this script with FilterIPs.pl which takes the problematic IPs and filters them from my firewall but if you don't want to run FilterIPs.pl at the end then either comment out or delete everything after line 40.
  * <i>Note: I you wish to run FilterIPs.pl after BadIps.pl make sure that these scripts are in the same directory and that you are using an account with sudo privleges since FilterIPs.pl uses a few sudo commands. </i>
  
  ---------------------------------------------------------------------------------------------------------------------------------------------------
 ## FilterIPs 
This script works after BadIPs.pl creates a .txt list of problematic IPs that have failed multiple ssh attempts. 
This script reads from BadIPs.txt and checks if these IPs are in the current iptables config. If any of these IPs already exist in the iptables this script will tell you. If they are not currently in the iptables then it will create an incoming drop rule for all ssh attempts from that IP. After it reads all the IP addresses from the BadIPs.txt file it will then print the current iptables configuration to show all any changes.

 - <i> Note: using iptables requires sudo privleges from the user account </i>
  - To run this script type `sudo perl FilterIPs.pl`
  
  ---------------------------------------------------------------------------------------------------------------------------------------------------  
  
  ## faileduserlog.pl 
This script works similar to the logincheck script but instead of tracking IPs and countries. It tracks the usernames in failed login attempts.
Unlike the logincheck script, there isn't anything we have to install to get this script to work. All you need to know is the log file location of where login attempts are stored.
- This script is currently setup to run on Debian or Ubuntu machines so the log file to read failed usernames is located at `/var/log/auth.log`.
- If you run CentOS/RHEL you will need to change the $see file in line 4 to `/var/log/secure`. For other os types, you will need to change the $see file to wherever failed login attempts are stored.
