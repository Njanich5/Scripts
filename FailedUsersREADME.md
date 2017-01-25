## FAILED USERS README
This script works similar to the logincheck script but instead of tracking IPs and countries. It tracks the usernames in failed login attempts.
Unlike the logincheck script, there isn't anything we have to install to get this script to work. All you need to know is the log file location of where login attempts are stored
<ul>
This script is currently setup to run on Debian or Ubuntu machines so the log file to read failed login attempts is located at /var/log/auth.log. <br>
If you run CentOS/RHEL you will need to change the $see file to '/var/log/secure'. For other os types, you will need to change the $syslog variable to wherever failed ssh attempts are stored. </ul>
