#!/bin/sh
GENFILE=$(tempfile)
CURRFILE=$(tempfile)

/bin/sed -e 's/#.*//' -e 's/[ ^I]*$//' -e '/^$/ d' < /etc/interspire/puppet-firewall.conf | /usr/bin/perl -lne '($chain, $policy) = ($_ =~ /^:(\w+) (\w+) \[\d+:\d+\]$/); if ($chain) { print ":$chain $policy [0:0]"; } else { print $_; }' | /bin/grep -v 'fail2ban' > $GENFILE
/sbin/iptables-save | /bin/sed -e 's/#.*//' -e 's/[ ^I]*$//' -e '/^$/ d' | /usr/bin/perl -lne '($chain, $policy) = ($_ =~ /^:(\w+) (\w+) \[\d+:\d+\]$/); if ($chain) { print ":$chain $policy [0:0]"; } else { print $_; }' | /bin/grep -v 'fail2ban' > $CURRFILE
if [ "$TERM" = "xterm-color" ]; then
	/usr/bin/colordiff -wu $CURRFILE $GENFILE
else
	/usr/bin/diff -wu $CURRFILE $GENFILE
fi