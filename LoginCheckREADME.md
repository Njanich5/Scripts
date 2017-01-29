##LOGINCHECK.PL README
logincheck.pl is a Linux/Unix script I made that checks for failed ssh login attempts, tracks which country and IP these failed attempts came from, and counts how many times each IP has tried to login. Before you try running logincheck.pl there are a few things you'll need to check and setup to make sure it works. 

<b>STEP 1 - Your log file</b><br>
- This script is currently setup to run on Debian or Ubuntu machines so the log file to read failed login attempts is located at `/var/log/auth.log` in line 8. 
- If you run CentOS/RHEL you will need to change the $syslog file to `/var/log/secure`. For other os types, you will need to change the $syslog variable to wherever failed ssh attempts are stored.


<b>STEP 2 - Install Geo::IP::PurePerl</b><br>
- A simple guide on how to install the Geo::IP::PurePerl module using CPAN can be found here: https://www.garron.me/en/bits/install-geoip-cpan-ubuntu.html

* *NOTE: You will need to change the last step to include PurePerl so the last step in that guide should be `install Geo::IP::PurePerl` 


<b>STEP 3 - Download GeoLiteCity database</b><br>
- Now to download the GeoLiteCity database type `wget -N http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz`

- Once you finish downloading the database we will need to unzip the file, to do this type `gunzip GeoLiteCity.dat.gz`

- Next, to install the database you will need to locate where your PurePerl module resides. A simple `locate PurePerl.pm` command should give you a path like `/usr/local/share/perl/5.18.2/Geo/IP/PurePerl.pm`
on ubuntu. If locate doesn't give you a file path run this command `sudo updatedb`. Once you locate the right path, copy it as we will use it later to tell the script where to read the GeoLiteCity database file.

- After you find the path we will then move the database into the same folder that your PurePerl module is located so on my ubuntu machine my command would look like this `sudo mv GeoLiteCity.dat /usr/local/share/perl/5.18.2/Geo/IP/` since this was the folder I found when I ran the previous locate command.

- Now edit the logincheck.pl script with a text editor of choice and change the filepath in line 25 to the path we copied before and add GeoLiteCity.dat to the end of the path. So my filepath in line 26 looks like this `/usr/local/share/perl/5.18.2/Geo/IP/GeoLiteCity.dat` Write and quit to save these changes once your filepath matches the one we found from our locate command.

- Once these steps are properly completed you should be all set to run logincheck.pl
