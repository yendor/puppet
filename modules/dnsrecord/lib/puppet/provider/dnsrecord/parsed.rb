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

          # rev dns zone
          # .1.1.10.in-addr.arpa:10.1.1.1:
          # interspire zone
          # .interspire:10.1.1.1:
          # Lines that start with = setup forward and reverse dns
          # =portal.interspire:10.1.1.1
          # +puppet.interspire:174.37.171.132
          # &interspire.corp::whitebook.interspire:::

          line =~ /^(.)/

          info "DEBUG: $1"

          case $1
            when "."
              parts = line[1, line.length].split(':')
              parts.each do |part|
                puts part
              end
          end

          return hash
        end

    def self.to_line(hash)
      return nil unless hash[:type]

      case hash[:type]
        when "."
          str = "%s%s:%s" % [hash[:type], hash[:name], hash[:value]]
      end

      str
    end

end