## faileduserlog.pl README
This script works similar to the logincheck script but instead of tracking IPs and countries. It tracks the usernames in failed login attempts.
Unlike the logincheck script, there isn't anything we have to install to get this script to work. All you need to know is the log file location of where login attempts are stored.
- This script is currently setup to run on Debian or Ubuntu machines so the log file to read failed usernames is located at `/var/log/auth.log`.
- If you run CentOS/RHEL you will need to change the $see file in line 4 to `/var/log/secure`. For other os types, you will need to change the $see file to wherever failed login attempts are stored.
