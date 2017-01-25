# Scripts
Collection of mostly perl and bash scripts

####LOGINCHECK.PL README
logincheck.pl is a Linux/Unix script I made that checks for failed ssh login attempts, tracks which country and IP these failed attempts came from, and counts how many times each IP has tried to login. Before you try running logincheck.pl there are a few things you'll need to check and setup to make sure it works. 

<b>STEP 1 - Your log file</b><br>
<ul> <li> This script is currently setup to run on Debian or Ubuntu machines so the log file to read failed login attempts is located at /var/log/auth.log. </li>
<li>If you run CentOS/RHEL you will need to change the $syslog file to '/var/log/secure'. For other os types, you will need to change the $syslog variable to wherever failed ssh attempts are stored.</li> </ul>


<b>STEP 2 - Install Geo::IP::PurePerl</b><br>
<ul> <li>A simple guide on how to install the Geo::IP::PurePerl module using CPAN can be found here:  https://www.garron.me/en/bits/install-geoip-cpan-ubuntu.html </ul> </li>

<ul><i>NOTE: You will need to change the last step to include PurePerl so the last step in that guide should be 'install Geo::IP::PurePerl'</i></ul>

<b>STEP 3 - Download GeoLiteCity database</b><br>
<ul><li>Now to download the GeoLiteCity database type <br><i> 'wget -N http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz'</i></li>

<li>Once you finish downloading the database we will need to unzip the file, to do this type <i>'gunzip GeoLiteCity.dat.gz'</i> </li>

<li>Next, to install the database you will need to locate where your PurePerl module resides. A simple <i>'locate PurePerl.pm'</i> command should give you a path like '/usr/local/share/perl/5.18.2/Geo/IP/PurePerl.pm' on ubuntu.</li>

<li><i>NOTE: this filepath may be different depending on how perl is setup on your os. You may need to change the file location in line 25 to the same folder you found from the previous locate command.</i></li>

<li>After you find the path we will then move the database into the same folder that your PurePerl module is located so on my ubuntu machine my command would look like this <i>'sudo mv GeoLiteCity.dat /usr/local/share/perl/5.18.2/Geo/IP/'</i> since this was the folder I found when I ran the previous locate command.</li> </ul>
Once these steps are properly completed you should be all set to run logincheck.pl
