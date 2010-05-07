require 'puppet/provider/parsedfile'

Puppet::Type.newtype(:shells) do
  @doc = "Manage shells in /etc/shells. For example::

  shells {\"/bin/bash\":
    ensure => present
  }

  There is also an optional target attribute if your
  shells file is located elsewhere."

  ensurable

  newparam(:shell, :namevar => true) do
    desc "The shell to manage"
    isnamevar
  end

  newproperty(:target) do
    desc "Location of the shells file"
    defaultto {
      if @resource.class.defaultprovider.ancestors.include?(Puppet::Provider::Parsefile)
        @resource.class.defaultprovider.default_target
      else
        nil
      end
    }
  end
end