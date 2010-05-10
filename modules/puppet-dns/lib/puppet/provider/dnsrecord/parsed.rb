require 'puppet/provider/parsedfile'
datafile = "/etc/tinydns/root/data"

Puppet::Type.type(:shells).provide(:parsed, :parent => Puppet::Provider::ParsedFile, :default_target => datafile, :filetype => :flat) do

    desc "The shells provider that uses the ParsedFile class"

    text_line :comment, :match => /^#/;
    text_line :blank, :match => /^\s*$/;

    record_line :parsed, :fields => %w{name}
end