require "chef/knife/glesys_base"

class Chef
  class Knife
    class GlesysServerInfo < Knife

      include Knife::GlesysBase

      banner "knife glesys server info SERVER"

      deps do
        require 'fog'
        require 'readline'
        Chef::Knife::Bootstrap.load_deps
      end

      def run
        server = connection.servers.get(@name_args.first)
        msg_pair("Server ID", server.serverid)
        state = case server.state.to_s.downcase
          when 'shutting-down','terminated','stopping','stopped' then ui.color(server.state, :red)
          when 'pending' then ui.color(server.state, :yellow)
          else ui.color(server.state, :green)
        end
        msg_pair("State", ui.color(state,:bold))
        msg_pair("Hostname", server.hostname)
        msg_pair("Description", server.description) if server.respond_to? :description # When fog supports description
        puts "\n"
        msg_pair("IPv4", server.iplist.select{|i| i["version"] == 4}.collect{|i| i["ipaddress"]}.join(", "))
        msg_pair("IPv6", server.iplist.select{|i| i["version"] == 6}.collect{|i| i["ipaddress"]}.join(", "))
        puts "\n"
        msg_pair("CPU Cores", server.cpucores)
        msg_pair("Memory", "#{server.memorysize} MB")
        msg_pair("Disk", "#{server.disksize} GB")
        puts "\n"
        msg_pair("Template", server.templatename)
        msg_pair("Platform", server.platform)
        msg_pair("Datacenter", server.datacenter)
        puts "\n"
        msg_pair("Transfer", "#{server.transfer['usage']} of #{server.transfer['max']} #{server.transfer['unit']}")
        msg_pair("Cost", "#{server.cost['amount']} #{server.cost['currency']} per #{server.cost['timeperiod']}")
      end

    end
  end
end
