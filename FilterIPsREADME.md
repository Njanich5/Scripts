##FilterIPs README
This script works after BadIPs.pl creates a .txt list of problematic IPs that have failed multiple ssh attempts. 
This script reads from BadIPs.txt and checks if these IPs are in the current iptables config. If any of these IPs already exist in the iptables this script will tell you. If they are not currently in the iptables then it will create an incoming drop rule for all ssh attempts from that IP. After it reads all the IP addresses from the BadIPs.txt file it will then print the current iptables configuration to show all any changes.

 - <i> Note: using iptables requires sudo privleges from the user account </i>
 - To run this script type `sudo perl FilterIPs.pl

