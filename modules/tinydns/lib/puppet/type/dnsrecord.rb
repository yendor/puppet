module Puppet
  newtype(:dnsrecord) do
    @doc = "Manage dns records"

    ensurable

    newparam(:name, :namevar => true) do
      desc "A text description of the rule"
      isnamevar
    end

    newproperty(:fqdn) do
      desc "The fully qualified name"
    end

    newproperty(:type) do
      desc "The dns record type, ., =, +, &"
      validate do |value|
        unless value =~ /^(?:\.|=|\+|&|%|@|\^|C|\')$/
          raise ArgumentError, "%s is not a valid tinydns record type" % value
        end
      end
    end

    newproperty(:ttl) do
      desc "The time to live of the record"
    end

    newproperty(:ipaddr) do
      desc "The value to point the dns record to"
    end

    newproperty(:value) do
      desc "The value of the TXT record, who who to point the PTR or CNAME record to"
    end

    newproperty(:stamp) do
      desc "The timestamp of the dns record"
    end

    newproperty(:location) do
      desc "The location to which dns records apply in split horizon dns setups"
    end

    newproperty(:host) do
      desc "The host name to use in dns records for mx and ns entries"
    end

    newproperty(:priority) do
      desc "The priority of the mx record"
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