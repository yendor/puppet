require "ipaddr"

module Puppet
  @@default_policies = {
    'mangle' => {
        'PREROUTING'  => 'ACCEPT',
        'INPUT'       => 'ACCEPT',
        'FORWARD'     => 'ACCEPT',
        'OUTPUT'      => 'ACCEPT',
        'POSTROUTING' => 'ACCEPT',
    },
    'filter' => {
        'INPUT'   => 'ACCEPT',
        'FORWARD' => 'ACCEPT',        
        'OUTPUT'  => 'ACCEPT',
    },
    'nat' => {
        'PREROUTING'  => 'ACCEPT',
        'POSTROUTING' => 'ACCEPT',
        'OUTPUT'      => 'ACCEPT',
    },
    'raw' => {
        'PREROUTING'  => 'ACCEPT',
        'OUTPUT'      => 'ACCEPT',
    }
  }
  @@custom_chains = {
    'filter' => {},
    'nat' => {},
    'mangle' => {},
    'raw' => {},
  }
  @@rules = {}
  @@current_rules = {}
  @@ordered_rules = {}
  @@total_rule_count = 0
  @@instance_count = 0
  @@table_counters = {
    'filter' => 1,
    'nat'    => 1,
    'mangle' => 1,
    'raw'    => 1
  }
  @@table_order = []
  
  notice("iptables module loading")

  @@current_iptables_rules = []
  if File.exist?('/proc/net/ip_tables_names')
      `/sbin/iptables-save`.each { |line|
        next if /^#/.match(line.strip)
        if line.match(/\[\d+:\d+\]/)
            line.sub!(/\[\d+:\d+\]/, '[0:0]')
            @@current_iptables_rules.push(line.strip)
        else
            @@current_iptables_rules.push(line.strip)
        end
        
        matches = line.match('^\*(filter|nat|mangle|raw)$')
        
        if matches
          @@table_order << matches[1]
        end
            
      }
  end

  @@firewall_conf = '/etc/firewall/puppet-firewall.conf'
  @@firewall_conf_tmp = '/etc/firewall/puppet-firewall.conf.tmp'

  @@usecidr = nil
  @@finalized = false

  # pre and post rules are loaded from files
  # pre.iptables post.iptables in /etc/puppet/iptables
  @@pre_file  = "/etc/iptables/conf.d/pre.iptables"
  @@post_file = "/etc/iptables/conf.d/post.iptables"

  # location where iptables binaries are to be found
  @@iptables_dir = "/sbin"

  # order in which the differents chains appear in iptables-save's output. Used
  # to sort the rules the same way iptables-save does.
  @@chain_order = {
    'PREROUTING'  => 1,
    'INPUT'       => 2,
    'FORWARD'     => 3,
    'OUTPUT'      => 4,
    'POSTROUTING' => 5,
  }
  
  @@table_chain_order = {
   'mangle' => ['PREROUTING', 'INPUT', 'FORWARD', 'OUTPUT', 'POSTROUTING'],
   'filter' => ['INPUT', 'FORWARD', 'OUTPUT'],
   'nat'    => ['PREROUTING', 'POSTROUTING', 'OUTPUT'],
   'raw'    => ['PREROUTING', 'OUTPUT'],
  }

  newtype(:iptables) do
    @doc = "Manipulate iptables rules"

    newparam(:defaultpolicy) do
      desc "The Default Policy for a table chain.
                Possible values are: 'ACCEPT', 'REJECT', 'DROP'
                    Default value is 'ACCEPT'"
    end

    newparam(:name) do
      desc "The name of the resource"
      isnamevar
    end

    newparam(:chain) do
      desc "holds value of iptables -A parameter.
                  Possible values are: 'INPUT', 'FORWARD', 'OUTPUT', 'PREROUTING', 'POSTROUTING'.
                  Default value is 'INPUT'"
      newvalues(:INPUT, :FORWARD, :OUTPUT, :PREROUTING, :POSTROUTING)
      defaultto "INPUT"
    end

    newparam(:customchain) do
      desc "create a custom chain...applies to filter table only"
    end
    newparam(:raw_rule) do
      desc "this is for just dumping raw iptables rules in, you need to also specify table parameter with this
                  usage is like so raw_rule => '-A INPUT -s 1.1.1.1 -j ACCEPT'"
    end

    newparam(:table) do
      desc "one of the following tables: 'nat', 'mangle',
                  'filter' and 'raw'. Default one is 'filter'"
      newvalues(:nat, :mangle, :filter, :raw)
      defaultto "filter"
    end

    newparam(:proto) do
      desc "holds value of iptables --protocol parameter.
                  Possible values are: 'tcp', 'udp', 'icmp', 'esp', 'ah', 'vrrp', 'igmp', 'all'.
                  Default value is 'all'"
      newvalues(:tcp, :udp, :icmp, :esp, :ah, :vrrp, :igmp, :all)
      defaultto "all"
    end

    newparam(:jump) do
      desc "holds value of iptables --jump target
                  Possible values are: 'ACCEPT', 'DROP', 'REJECT', 'DNAT', 'LOG', 'MASQUERADE', 'REDIRECT'."
      #newvalues(:ACCEPT, :DROP, :REJECT, :DNAT, :LOG, :MASQUERADE, :REDIRECT)
      defaultto "DROP"
    end

    newparam(:source) do
      desc "value for iptables --source parameter"
    end

    newparam(:destination) do
      desc "value for iptables --destination parameter"
    end

    newparam(:sport) do
      desc "holds value of iptables [..] --source-port parameter.
                  If array is specified, values will be passed to multiport module.
                  Only applies to tcp/udp."
      defaultto ""
    end

    newparam(:dport) do
      desc "holds value of iptables [..] --destination-port parameter.
                  If array is specified, values will be passed to multiport module.
                  Only applies to tcp/udp."
      defaultto ""
    end

    newparam(:iniface) do
      desc "value for iptables --in-interface parameter"
    end

    newparam(:outiface) do
      desc "value for iptables --out-interface parameter"
    end

    newparam(:todest) do
      desc "value for iptables '-j DNAT --to-destination' parameter"
      defaultto ""
    end

    newparam(:reject) do
      desc "value for iptables '-j REJECT --reject-with' parameter"
      defaultto ""
    end

    newparam(:log_level) do
      desc "value for iptables '-j LOG --log-level' parameter"
      defaultto ""
    end

    newparam(:log_prefix) do
      desc "value for iptables '-j LOG --log-prefix' parameter"
      defaultto ""
    end

    newparam(:icmp) do
      desc "value for iptables '-p icmp --icmp-type' parameter"
      defaultto ""
    end

    newparam(:state) do
      desc "value for iptables '-m state --state' parameter.
                  Possible values are: 'INVALID', 'ESTABLISHED', 'NEW', 'RELATED'."
    end

    newparam(:limit) do
      desc "value for iptables '-m limit --limit' parameter.
                  Example values are: '50/sec', '40/min', '30/hour', '10/day'."
      defaultto ""
    end

    newparam(:burst) do
      desc "value for '--limit-burst' parameter.
                  Example values are: '5', '10'."
      defaultto ""
    end

    newparam(:redirect) do
      desc "value for iptables '-j REDIRECT --to-ports' parameter."
      defaultto ""
    end

    # Fix this function
    def load_rules_from_file(rules, file_name, action)
      if File.exist?(file_name)
        counter = 0
        File.open(file_name, "r") do |infile|
          while (line = infile.gets)
            next unless /^\s*[^\s#]/.match(line.strip)
            table = line[/-t\s+\S+/]
            table = "-t filter" unless table
            table.sub!(/^-t\s+/, '')
            rules[table] = [] unless rules[table]
            rule =
              { 'table'         => table,
                'full rule'     => line.strip,
              }

            if( action == :prepend )
              rules[table].insert(counter, rule)
            else
              rules[table].push(rule)
            end

            counter += 1
          end
        end
      end
    end

    # Generate Rules from dynamically added rules from fail2ban
    def load_dynamic_rules_from_fail2ban(rules)
        counter = 0
        @@current_iptables_rules.each {|l|
            if /^:(fail2ban)-/.match(l)
                table = $1
                line = l.strip
                @@custom_chains['filter'][line] = 1
            elsif /-j\sfail2ban-/.match(l)
                table = "filter"
                rules[table] = [] unless rules[table]
                rule = {
                    'name'          => 'dynamic fail2ban rules',
                    'table'         => table,
                    'full rule'     => l.strip,
                }

                rules[table].insert(counter, rule)

                counter += 1
            elsif /-A\sfail2ban-/.match(l)
                table = 'filter'
                rules[table] = [] unless rules[table]
                rule = {
                    'name'          => 'dynamic fail2ban rules',
                    'table'         => 'filter',
                    'full rule'     => l.strip,
                }

                rules[table].insert(counter, rule)

                counter += 1
            end
        }
    end

    # finalize() gets run once every iptables resource has been declared.
    # It decides if puppet resources differ from currently active iptables
    # rules and applies the necessary changes.
    def finalize
      # Comment out table_order length checking for now, as it will error if a particular server does
      # not have kernel modules enabled that provides specific tables
      # if @@table_order.length != 4
      #   err("The wrong number of tables were found in the iptables-save output. Expected 4 got " + @@table_order.length.to_s)
      #   return
      # end
      require 'pp'
      pp(@@table_chain_order)
      
      # sort rules by alphabetical order, grouped by chain, else they arrive in
      # random order and cause puppet to reload iptables rules.
      @@rules.each_key {|key|
        @@rules[key] = @@rules[key].sort_by {|rule| [rule["chain_prio"], rule["name"]] }
      }

      # load fail2ban dynamic rules
      load_dynamic_rules_from_fail2ban(@@rules)
      # load pre and post rules
      load_rules_from_file(@@rules, @@pre_file, :prepend)
      load_rules_from_file(@@rules, @@post_file, :append)

      # add numbered version to each rule
      @@table_counters.each_key { |table|
        rules_to_set = @@rules[table]
        if rules_to_set
          counter = 1
          rules_to_set.each { |rule|
            rule['numbered rule'] = counter.to_s + " "+rule["full rule"]
            counter += 1
          }
        end
      }
      if @@rules
        File.open(@@firewall_conf_tmp,'w') { |fh|
          # Print out a warning header that this is a puppet managed file
          fh.puts "# WARNING: This file is generated out of puppet...do not modify any contents in here...you have been warned"
          # we need to print out the tables in the correct order
          @@table_order.each { |table|
            fh.puts "*#{table}"
            #print out the default chain policies
            @@default_policies[table].keys.sort{|a,b| @@table_chain_order[table].index(a) <=> @@table_chain_order[table].index(b)}.each { |chain|
                policy = @@default_policies[table][chain]
                fh.puts ":#{chain} #{policy} [0:0]"
            }
            #print out any custom chains
            if ! @@custom_chains[table].nil? and @@custom_chains[table].size >= 1
                @@custom_chains[table].sort.each { |chain,status|
                    fh.puts chain
                }
            end
            #print out the defined rules
            pp(@@rules)
            if ! @@rules[table].nil? and @@rules[table].size >= 1
                @@rules[table].each { |value|
                    fh.puts "# rule name: #{value['name']}"
                    fh.puts value['full rule']
                }
            end
            #print out a COMMIT to mark the end of the table
            fh.puts "COMMIT"
          }
        }
        rules_differ = 0
        # Now we need to check if our new file is different from the last run and if so iptables-restore and move it into place
        if File.exist? @@firewall_conf
            system("/usr/bin/diff","-u",@@firewall_conf,@@firewall_conf_tmp)
            if ( $? != 0 )
                notice("New rules were found:")
                rules_differ = 1
            end
        else
            rules_differ = 1
        end

        if rules_differ >= 1
            FileUtils.mv @@firewall_conf_tmp, @@firewall_conf
            #system("/sbin/iptables-restore < #{@@firewall_conf}")
        else
            FileUtils.rm @@firewall_conf_tmp
        end
        #else
        #    error("Failed to set new rules in iptables")
        #end
      end
      @@finalized = true

    end

    def finalized?
      if defined? @@finalized
        return @@finalized
      else
        return false
      end
    end

    def properties
      @@ordered_rules[self.name] = @@instance_count
      @@instance_count += 1

      if @@instance_count == @@total_rule_count
        self.finalize unless self.finalized?
      end
      return super
    end

    # Reset class variables to their initial value
    def self.clear
      @@rules = {}

      @@current_rules = {}

      @@ordered_rules = {}

      @@total_rule_count = 0

      @@instance_count = 0

      @@table_counters = {
        'filter' => 1,
        'nat'    => 1,
        'mangle' => 1,
        'raw'    => 1
      }

      @@finalized = false
      super
    end


    def initialize(args)
      super(args)
      notice("iptables initializing")

      if @@usecidr == nil
        iptablesversion = `#{@@iptables_dir}/iptables --version`.scan(/ v([0-9\.]+)/)
        iptablesversion = iptablesversion[0][0].split(".")
        if iptablesversion[0].to_i < 2 and iptablesversion[1].to_i < 4
          @@usecidr = false
        else
          @@usecidr = true
        end
      end

      invalidrule = false
      @@total_rule_count += 1

      table = value(:table).to_s
      @@rules[table] = [] unless @@rules[table]

      full_string = ""

      if value(:table).to_s == "filter" and ["PREROUTING", "POSTROUTING"].include?(value(:chain).to_s)
        invalidrule = true
        err("PREROUTING and POSTROUTING cannot be used in table 'filter'. Ignoring rule.")
      elsif  value(:table).to_s == "nat" and ["INPUT", "FORWARD"].include?(value(:chain).to_s)
        invalidrule = true
        err("INPUT and FORWARD cannot be used in table 'nat'. Ignoring rule.")
      elsif  value(:table).to_s == "raw" and ["INPUT", "FORWARD", "POSTROUTING"].include?(value(:chain).to_s)
        invalidrule = true
        err("INPUT, FORWARD and POSTROUTING cannot be used in table 'raw'. Ignoring rule.")
      else
        full_string += "-A " + value(:chain).to_s
      end

      source = value(:source).to_s
      if source != ""
        ip = IpCidr.new(source)
        if @@usecidr
          source = ip.cidr
        else
          source = ip.to_s
          source += sprintf("/%s", ip.netmask) unless ip.prefixlen == 32
        end
        full_string += " -s " + source
      end

      destination = value(:destination).to_s
      if destination != ""
        ip = IpCidr.new(destination)
        if @@usecidr
          destination = ip.cidr
        else
          destination = ip.to_s
          destination += sprintf("/%s", ip.netmask) unless ip.prefixlen == 32
        end
        full_string += " -d " + destination
      end

      if value(:iniface).to_s != ""
        if ["INPUT", "FORWARD", "PREROUTING"].include?(value(:chain).to_s)
          full_string += " -i " + value(:iniface).to_s
        else
          invalidrule = true
          err("--in-interface only applies to INPUT/FORWARD/PREROUTING. Ignoring rule.")
        end
      end
      if value(:outiface).to_s != ""
        if ["OUTPUT", "FORWARD", "POSTROUTING"].include?(value(:chain).to_s)
          full_string += " -o " + value(:outiface).to_s
        else
          invalidrule = true
          err("--out-interface only applies to OUTPUT/FORWARD/POSTROUTING. Ignoring rule.")
        end
      end

      if value(:proto).to_s != "all"
        full_string += " -p " + value(:proto).to_s
        if not ["vrrp", "igmp"].include?(value(:proto).to_s)
          full_string += " -m " + value(:proto).to_s
        end
      end
      if value(:sport).to_s != ""
        if ["tcp", "udp"].include?(value(:proto).to_s)
          if value(:sport).class.to_s == "Array"
            if value(:sport).length <= 15
              full_string += " -m multiport --sports " + value(:sport).join(",")
            else
              invalidrule = true
              err("multiport module only accepts <= 15 ports. Ignoring rule.")
            end
          else
            full_string += " --sport " + value(:sport).to_s
          end
        else
          invalidrule = true
          err("--source-port only applies to tcp/udp. Ignoring rule.")
        end
      end
      if value(:dport).to_s != ""
        if ["tcp", "udp"].include?(value(:proto).to_s)
          if value(:dport).class.to_s == "Array"
            if value(:dport).length <= 15
              full_string += " -m multiport --dports " + value(:dport).join(",")
            else
              invalidrule = true
              err("multiport module only accepts <= 15 ports. Ignoring rule.")
            end
          else
            full_string += " --dport " + value(:dport).to_s
          end
        else
          invalidrule = true
          err("--destination-port only applies to tcp/udp. Ignoring rule.")
        end
      end
      if value(:icmp).to_s != ""
        if value(:proto).to_s != "icmp"
          invalidrule = true
          err("--icmp-type only applies to icmp. Ignoring rule.")
        else
          full_string += " --icmp-type " + value(:icmp).to_s
        end
      end

      # let's specify the order of the states as iptables uses them
      state_order = ["INVALID", "NEW", "RELATED", "ESTABLISHED"]
      if value(:state).class.to_s == "Array"

        invalid_state = false
        value(:state).each {|v|
          invalid_state = true unless state_order.include?(v)
        }

        if value(:state).length <= state_order.length and not invalid_state

          # return only the elements that appear in both arrays.
          # This filters out bad entries (unfortunately silently), and orders the entries
          # in the same order as the 'state_order' array
          states = state_order & value(:state)

          full_string += " -m state --state " + states.join(",")
        else
          invalidrule = true
          err("'state' accepts any the following states: #{state_order.join(", ")}. Ignoring rule.")
        end
      elsif value(:state).to_s != ""
        if state_order.include?(value(:state))
          full_string += " -m state --state " + value(:state).to_s
        else
          invalidrule = true
          err("'state' accepts any the following states: #{state_order.join(", ")}. Ignoring rule.")
        end
      end

      if value(:limit).to_s != ""
        limit_value = value(:limit).to_s
        if not limit_value.include? "/"
          invalidrule = true
          err("Please append a valid suffix (sec/min/hour/day) to the value passed to 'limit'. Ignoring rule.")
        else
          limit_value = limit_value.split("/")
          if limit_value[0] !~ /^[0-9]+$/
            invalidrule = true
            err("'limit' values must be numeric. Ignoring rule.")
          elsif ["sec", "min", "hour", "day"].include? limit_value[1]
            full_string += " -m limit --limit " + value(:limit).to_s
          else
            invalidrule = true
            err("Please use only sec/min/hour/day suffixes with 'limit'. Ignoring rule.")
          end
        end
      end

      if value(:burst).to_s != ""
        if value(:limit).to_s == ""
          invalidrule = true
          err("'burst' makes no sense without 'limit'. Ignoring rule.")
        elsif value(:burst).to_s !~ /^[0-9]+$/
          invalidrule = true
          err("'burst' accepts only numeric values. Ignoring rule.")
        else
          full_string += " --limit-burst " + value(:burst).to_s
        end
      end

      full_string += " -m comment --comment " + shellescape(value(:name)[0, 256].to_s)

      full_string += " -j " + value(:jump).to_s

      if value(:jump).to_s == "DNAT"
        if value(:table).to_s != "nat"
          invalidrule = true
          err("DNAT only applies to table 'nat'.")
        elsif value(:todest).to_s == ""
          invalidrule = true
          err("DNAT missing mandatory 'todest' parameter.")
        else
          full_string += " --to-destination " + value(:todest).to_s
        end
      elsif value(:jump).to_s == "REJECT"
        if value(:reject).to_s != ""
          full_string += " --reject-with " + value(:reject).to_s
        end
      elsif value(:jump).to_s == "LOG"
        if value(:log_level).to_s != ""
          full_string += " --log-level " + value(:log_level).to_s
        end
        if value(:log_prefix).to_s != ""
          # --log-prefix has a 29 characters limitation.
          log_prefix = "\"" + value(:log_prefix).to_s[0,27] + ": \""
          full_string += " --log-prefix " + log_prefix
        end
      elsif value(:jump).to_s == "MASQUERADE"
        if value(:table).to_s != "nat"
          invalidrule = true
          err("MASQUERADE only applies to table 'nat'.")
        end
      elsif value(:jump).to_s == "REDIRECT"
        if value(:redirect).to_s != ""
          full_string += " --to-ports " + value(:redirect).to_s
        end
      end

      if ! value(:raw_rule).nil?
        if value(:table).nil?
            invalidrule = true
            err("You must supply a table with raw rule eg table => 'filter'")
        end
      end
      
      chain_prio = @@chain_order[value(:chain).to_s]

      debug("iptables param: #{full_string}")

      if invalidrule != true
        if ! value(:defaultpolicy).nil?
            table  = value(:table).to_s
            chain  = value(:chain).to_s
            defaultpolicy = value(:defaultpolicy).to_s

            @@default_policies[table][chain] = defaultpolicy
        elsif ! value(:customchain).nil?
            chain = ":" + value(:customchain).to_s + " - [0:0]"
            @@custom_chains['filter'][chain] = 1
            unless @@table_chain_order[value(:table).to_s].include?(value(:customchain).to_s)
              @@table_chain_order[value(:table).to_s].push(value(:customchain).to_s)
            end
        elsif ! value(:raw_rule).nil?
            chain = value(:raw_rule).to_s.match('^\-\w (\S+)')[1]
            #  
            #  unless chain
          
            @@rules[table][chain].push({
                 'name'         => value(:name).to_s,
                 'chain_prio'   => chain_prio.to_s,
                 'full rule'    => value(:raw_rule).to_s,
            })
        else
            @@rules[table][chain].push({
                 'name'          => value(:name).to_s,
                 'chain'         => value(:chain).to_s,
                 'table'         => value(:table).to_s,
                 'proto'         => value(:proto).to_s,
                 'jump'          => value(:jump).to_s,
                 'source'        => value(:source).to_s,
                 'destination'   => value(:destination).to_s,
                 'sport'         => value(:sport).to_s,
                 'dport'         => value(:dport).to_s,
                 'iniface'       => value(:iniface).to_s,
                 'outiface'      => value(:outiface).to_s,
                 'todest'        => value(:todest).to_s,
                 'reject'        => value(:reject).to_s,
                 'redirect'      => value(:redirect).to_s,
                 'log_level'     => value(:log_level).to_s,
                 'log_prefix'    => value(:log_prefix).to_s,
                 'icmp'          => value(:icmp).to_s,
                 'state'         => value(:state).to_s,
                 'limit'         => value(:limit).to_s,
                 'burst'         => value(:burst).to_s,
                 'chain_prio'    => chain_prio.to_s,
                 'full rule'     => full_string,
            })
        end
      end
    
    end

    def shellescape(str)
      return '""' if str.empty?

      str = str.dup
      str.gsub!(/([$\"`\\])/n, "\\\\\\1")
      return "\"#{str}\""
    end
  end
end


# This class is a lame copy of:
# http://article.gmane.org/gmane.comp.lang.ruby.core/10013/

class IpCidr < IPAddr

  def netmask
    _to_string(@mask_addr)
  end

  def prefixlen
    m = case @family
    when Socket::AF_INET
      IN4MASK
    when Socket::AF_INET6
      IN6MASK
    else
      raise "unsupported address family"
    end
    return $1.length if /\A(1*)(0*)\z/ =~ (@mask_addr & m).to_s(2)
    raise "bad addr_mask format"
  end

  def cidr
    cidr = sprintf("%s/%s", self.to_s, self.prefixlen)
    cidr
  end

end
