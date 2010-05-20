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

          case line[1, 2]
            when "=", "+"

              parts = line[1, line.length].split(':')
              parts.each do |part|
                unless hash[:name]
                  hash[:name] = part
                  next
                end

                unless hash[:value]
                  hash[:value] = part
                  next
                end
              end
          end

          return hash
        end

    def self.to_line(hash)
      return nil unless hash[:type]

      str = hash[:type]

      case hash[:type]
        when "=", "+"
          str += [hash[:name], hash[:value], "", hash[:ttl], ""].join(":").sub(/:+$/, "")
      end
    end

end