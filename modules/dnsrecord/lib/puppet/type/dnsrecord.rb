module Puppet
  newtype(:dnsrecord) do
    @doc = "Manage dns records"

    ensurable

    newparam(:fqdn, :namevar => true) do
      desc "The fully qualified name"
      isnamevar
    end

    newproperty(:type) do
      desc "The dns record type, A, TXT, MX, NS, PTR, SRV, AAAA"
    end

    newproperty(:ttl) do
      desc "The time to live of the record"
    end

    newproperty(:value) do
      desc "The value to point the dns record to"
    end

    newproperty(:target) do
      desc "The file in which to store the tinydns data file in plain text."

      defaultto { if @resource.class.defaultprovider.ancestors.include?(Puppet::Provider::ParsedFile)
              @resource.class.defaultprovider.default_target
          else
              nil
          end
      }
    end
  end
end