require 'puppet/provider/parsedfile'
datafile = "/etc/tinydns/root/data"

Puppet::Type.type(:dnsrecord).provide(:parsed, :parent => Puppet::Provider::ParsedFile, :default_target => datafile, :filetype => :flat) do

    desc "The tinydns data file"

    text_line :comment, :match => /^#/;
    text_line :blank, :match => /^\s*$/;

    record_line self.name,
        :fields => %w{type name value ttl},
        :joiner => ":",
        :separator => ":" do |line|
          hash = {}

          if line.sub!(/(.):([^:]*):([^:]*):([^:]*):([^:]*):([^:]*):/)
            hash[:type] = $1
            hash[:name] = $2
            hash[:value] = $3
            hash[:ttl] = $5
          end
          return hash
        end


    def self.to_line(hash)
      str = "%s:%s:%s::%s:" % [hash[:type], hash[:name], hash[:value], hash[:ttl]]
    end

end