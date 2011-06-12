require 'puppet/provider/parsedfile'
datafile = "/etc/postgresql/8.3/main/pg_hba.conf"

Puppet::Type.type(:pgsqlauth).provide(:parsed, :parent => Puppet::Provider::ParsedFile, :default_target => datafile, :filetype => :flat) do

    desc "The pg_hba.conf authorisation file"

    text_line :comment, :match => %r{^#}, :post_parse => proc { |hash|
        if hash[:line] =~ /Puppet Name: (.+)\s*$/
            hash[:name] = $1
        end
    }

    text_line :blank, :match => /^\s*$/;

    record_line self.name,
        :fields => %w{type database user cidr method},
        :optional => %w{},
        :separator => ":" do |line|
          hash = {}
          empty = {}

          parts = line.split('\s+')
          hash[:type] = parts[0] if parts[0]
          hash[:database] = parts[1] if parts[1]
          hash[:user] = parts[2] if parts[2]
          hash[:cidr] = parts[3] if parts[3]
          hash[:method] = parts[4] if parts[4]

          return hash
        end

    def self.to_line(hash)
      return nil unless hash[:type]

      str = ""

      if hash[:name]
        str = "# Puppet Name: %s\n" % hash[:name]
      end

      str += [hash[:type], hash[:database], hash[:user], hash[:cidr], hash[:method]]

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