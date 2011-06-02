#
# Regular cron jobs for the mpdas package
#
0 4	* * *	root	[ -x /usr/bin/mpdas_maintenance ] && /usr/bin/mpdas_maintenance
