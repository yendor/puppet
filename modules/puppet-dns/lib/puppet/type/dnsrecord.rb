Puppet::Type.newtype(:dnsrecord) do
  @doc = "Manage dns records"

  ensurable

  newparam(:fqdn, :namevar => true) do
    desc "The fully qualified name"
    isnamevar
  end

  newparam(:type) do
    desc "The dns record type, A, TXT, MX, NS, PTR, SRV, AAAA"
  end

  newparam(:ttl) do
    desc "The time to live of the record"
  end

end