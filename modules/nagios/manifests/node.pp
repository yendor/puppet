class nagios::node {
	Class["nagios::server"] -> Class["nagios::common"]
}