##BlockIPs README
This script work after BadIPs.pl creates a .txt list of problematic IPs that have failed multiple ssh attempts. This script reads from BadIPs.txt and checks if these IPs are in the current iptables config. If any of these IPs already exist in the iptables this script will tell you. If they are not currently in the iptables then it will create an incoming drop rule for all ssh attempts from that IP. After it reads all the IP addresses from the BadIPs.txt file it will then print the current iptables configuration to show all any changes.

 <i> Note: using iptables requires sudo privleges from the user account </i>

- This script is currently setup to run on Debian or Ubuntu machines so the log file to read failed usernames is located at `/var/log/auth.log`.
- If you run CentOS/RHEL you will need to change the $see file in line 4 to `/var/log/secure`. For other os types, you will need to change the $see file to wherever failed login attempts are stored.
