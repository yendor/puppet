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
end