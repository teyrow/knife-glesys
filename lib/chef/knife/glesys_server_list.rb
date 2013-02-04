require "chef/knife/glesys_base"

class Chef
  class Knife
    class GlesysServerList < Knife

      include Knife::GlesysBase

      banner "knife glesys server list"

      deps do
        require 'fog'
        require 'readline'
        Chef::Knife::Bootstrap.load_deps
      end

      def run

        server_list = [
          ui.color('ID', :bold),
          ui.color("Hostname", :bold),
          ui.color("Platform", :bold),
          ui.color("Datacenter", :bold),
        ].flatten.compact

        connection.servers.all.each do |server|
          server_list << server.serverid.to_s
          server_list << server.hostname
          server_list << server.platform
          server_list << server.datacenter
        end

        puts ui.list(server_list, :columns_across, 4)
      end

    end
  end
end
