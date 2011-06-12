module Puppet
  newtype(:pgsqlauth) do
    @doc = "Manage postgresql auth records in the pg_hba.conf"

    ensurable

    newparam(:name, :namevar => true) do
      desc "A text description of the rule"
      isnamevar
    end

    newproperty(:type) do
      desc "The type of auth record"
      validate do |value|
        unless value =~ /^(local|host|hostssl|hostnossl)$/
          raise ArgumentError, "%s is not a valid type" % value
        end
      end
    end

    newproperty(:database) do
      desc "The database name"
    end

    newproperty(:user) do
      desc "The username to give access to"
    end

    newproperty(:cidr) do
      desc "The cidr style ip range to give access from"
    end

    newproperty(:method) do
      desc "The auth method to use"
      validate do |value|
        unless value =~ /^(trust|reject|md5|crypt|password|krb5|ident|ldap|pam)$/
          raise ArgumentError, "%s is not a valid auth method" % value
        end
      end
    end

    newproperty(:target) do
      desc "The file in which to store the pg_hba.conf file in plain text."

      defaultto { if @resource.class.defaultprovider.ancestors.include?(Puppet::Provider::ParsedFile)
              @resource.class.defaultprovider.default_target
          else
              nil
          end
      }
    end
  end
end