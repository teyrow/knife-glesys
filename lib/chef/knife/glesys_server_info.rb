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
        msg_pair("State", ui.color(color_state(server.state),:bold))
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
        msg_pair("Image", server.templatename)
        msg_pair("Platform", server.platform)
        msg_pair("Datacenter", server.datacenter)
        puts "\n"
        msg(ui.color("Current Usage:",:bold))
        msg_pair("Transfer", "#{ui.color(server.usage['transfer']['usage'].to_s, :yellow)} of #{server.usage['transfer']['max']} #{server.usage['transfer']['unit']}")
        msg_pair("Memory", "#{ui.color(server.usage['memory']['usage'].to_s, :yellow)} of #{server.usage['memory']['max']} #{server.usage['memory']['unit']}")
        msg_pair("CPU", "#{ui.color(server.usage['cpu']['usage'].to_s, :yellow)} of #{server.usage['cpu']['max']} #{server.usage['cpu']['unit']}")
        msg_pair("Disk", "#{ui.color(server.usage['disk']['usage'].to_s, :yellow)} of #{server.usage['disk']['max']} #{server.usage['disk']['unit']}")
        msg_pair("Cost", "#{ui.color(server.cost['amount'].to_s, :yellow)} #{server.cost['currency']} per #{server.cost['timeperiod']}")
      end

    end
  end
end
