require 'puppet/provider/parsedfile'
datafile = "/etc/tinydns/root/data"

Puppet::Type.type(:dnsrecord).provide(:parsed, :parent => Puppet::Provider::ParsedFile, :default_target => datafile, :filetype => :flat) do

    desc "The tinydns data file"

    text_line :comment, :match => /^#/;
    text_line :blank, :match => /^\s*$/;

    info "The tinydns data file"

    @fields = [:type, :fqdn, :value, :ttl]
    @optional = [:ttl]

    record_line self.name,
        :fields => @fields,
        :joiner => ":",
        :separator => ":",
        :rts => true,
        :optional => @optional
end