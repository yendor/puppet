require 'puppet/provider/parsedfile'
datafile = "/etc/tinydns/root/data"

Puppet::Type.type(:dnsrecord).provide(:parsed, :parent => Puppet::Provider::ParsedFile, :default_target => datafile, :filetype => :flat) do

    desc "The tinydns data file"

    text_line :comment, :match => /^#/;
    text_line :blank, :match => /^\s*$/;

    record_line self.name,
        :fields => %w{type name value ttl},
        :optional => %w{ttl},
        :separator => ":" do |line|
          hash = {}
          empty = {}

          hash[:type] = line[0, 1]

          case line[0, 1]
            when "=", "+", "."
              parts = line[1, line.length].split(':')

              hash[:name] = parts[0] if parts[0]
              hash[:value] = parts[1] if parts[1]
              hash[:ttl] = parts[2] if parts[2]

            when "&"
              parts = line[1, line.length].split(':')

              hash[:name] = parts[0] if parts[0]
              hash[:value] = parts[2] if parts[2]
          end

          return hash
        end

    def self.to_line(hash)
      return nil unless hash[:type]

      str = hash[:type]

      case hash[:type]
        when "=", "+"
          str += [hash[:name], hash[:value], hash[:ttl], ""].join(":").sub(/:+$/, "")
        when "."
          str += [hash[:name], hash[:value]].join(":").sub(/:+$/, "")
        when "&"
          str += [hash[:name], "", hash[:value]].join(":").sub(/:+$/, "")
      end
    end

end