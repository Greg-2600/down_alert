# down_alert

A friend requested a simple solution to receive an email / sms notification when a device behind their cellular modem lost power.  This program iterates through a flat file containing IP addresses or hostnames they are intersted in mornitoring, and in the event one or more of the hosts stop responding to pings - sends a notification.

# Pre-release, reporter not implemented

TODO:
* reporter data flat file (maybe enhance targets.txt to csv with notification endpoint)
* reporter (smtp to sms gateway)
* cron or service solution


Usage:

echo "host.mydoma.in" > targets.txt
bash down_alert.sh
