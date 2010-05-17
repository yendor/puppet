require 'puppet/provider/parsedfile'
datafile = "/etc/tinydns/root/data"

Puppet::Type.type(:dnsrecord).provide(:dnsrecord, :parent => Puppet::Provider::ParsedFile, :default_target => datafile, :filetype => :flat) do

    desc "The tinydns data file"

    text_line :comment, :match => /^#/;
    text_line :blank, :match => /^\s*$/;

    record_line :parsed, :fields => %w{name}
end