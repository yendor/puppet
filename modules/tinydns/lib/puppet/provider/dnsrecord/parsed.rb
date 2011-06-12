require 'puppet/provider/parsedfile'
datafile = "/etc/tinydns/root/data"

Puppet::Type.type(:dnsrecord).provide(:parsed, :parent => Puppet::Provider::ParsedFile, :default_target => datafile, :filetype => :flat) do

    desc "The tinydns data file"



    text_line :comment, :match => %r{^#}, :post_parse => proc { |hash|
        if hash[:line] =~ /Puppet Name: (.+)\s*$/
            hash[:name] = $1
        end
    }

    text_line :blank, :match => /^\s*$/;

    record_line self.name,
        :fields => %w{type fqdn value ttl stamp location priority host ipaddr},
        :optional => %w{ttl stamp location priority host ipaddr value},
        :separator => ":" do |line|
          hash = {}
          empty = {}

          hash[:type] = line[0, 1]

          parts = line[1, line.length].split(':')

          case hash[:type]
            when "%"
              # % is a location record for split horizon dns
              hash[:fqdn] = parts[0] if parts[0]
              hash[:ipaddr] = parts[1] if parts[1]
            when ".", "&"
              # . is soa, ns and a record, & is ns and a record
              hash[:fqdn] = parts[0] if parts[0]
              hash[:ipaddr] = parts[1] if parts[1]
              hash[:host] = parts[2] if parts[2]
              hash[:ttl] = parts[3] if parts[3]
              hash[:stamp] = parts[4] if parts[4]
              hash[:location] = parts[5] if parts[5]
            when "=", "+"
              # + is a record, = is a record and ptr record
              hash[:fqdn] = parts[0] if parts[0]
              hash[:ipaddr] = parts[1] if parts[1]
              hash[:ttl] = parts[2] if parts[2]
              hash[:stamp] = parts[3] if parts[3]
              hash[:location] = parts[4] if parts[4]
            when "@"
              # MX Record
              hash[:fqdn] = parts[0] if parts[0]
              hash[:ipaddr] = parts[1] if parts[1]
              hash[:host] = parts[2] if parts[2]
              hash[:priority] = parts[3] if parts[3]
              hash[:ttl] = parts[4] if parts[4]
              hash[:stamp] = parts[5] if parts[5]
              hash[:location] = parts[6] if parts[6]
            when "'", "^", "C"
              # ' is TXT Record, ^ is ptr record, C is CNAME record
              hash[:fqdn] = parts[0] if parts[0]
              hash[:value] = parts[1] if parts[1]
              hash[:ttl] = parts[2] if parts[2]
              hash[:stamp] = parts[3] if parts[3]
              hash[:location] = parts[4] if parts[4]
            when "Z"
              # Z is a zone record

            when ":"
              # : is a generic record
          end

          return hash
        end

    def self.to_line(hash)
      return nil unless hash[:type]

      str = ""

      if hash[:name]
        str = "# Puppet Name: %s\n" % hash[:name]
      end

      str += hash[:type]

      case hash[:type]
        when "%"
          str += [hash[:fqdn], hash[:ipaddr]]
        when ".", "&"
          str += [hash[:fqdn], hash[:ipaddr], hash[:host], hash[:ttl], hash[:stamp], hash[:location]].join(":").sub(/:+$/, "")
        when "=", "+"
          str += [hash[:fqdn], hash[:ipaddr], hash[:ttl], hash[:stamp], hash[:location]].join(":").sub(/:+$/, "")

        when "@"
          str += [hash[:fqdn], hash[:ipaddr], hash[:host], hash[:priority], hash[:ttl], hash[:stamp], hash[:location]].join(":").sub(/:+$/, "")
        when "'", "^", "C"
          str += [hash[:fqdn], hash[:value], hash[:ttl], hash[:stamp], hash[:location]].join(":").sub(/:+$/, "")

      end
    end

    def self.prefetch_hook(records)
      name = nil
      result = records.each { |record|
        case record[:record_type]
          when :comment
            if record[:name]
              name = record[:name]
              record[:skip] = true
            end
          when :blank
            # skip it
          else
            if name
              record[:name] = name
              name = nil
            end
        end
      }.reject { |record| record[:skip] }
      result
    end
end