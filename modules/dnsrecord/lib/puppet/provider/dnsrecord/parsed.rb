require 'puppet/provider/parsedfile'
datafile = "/etc/tinydns/root/data"

Puppet::Type.type(:dnsrecord).provide(:parsed, :parent => Puppet::Provider::ParsedFile, :default_target => datafile, :filetype => :flat) do

    desc "The tinydns data file"

    text_line :comment, :match => /^#/;
    text_line :blank, :match => /^\s*$/;

    info "The tinydns data file '%s' " % :ttl

    @optional = [:ttl]

    record_line self.name,
        :fields => %w{type fqdn value ttl},
        :joiner => ":",
        :separator => ":",
        :rts => true,
        :optional => @optional
end