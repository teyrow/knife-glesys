require "chef/knife/glesys_base"

class Chef
  class Knife
    class GlesysServerCreate < Knife

      include Knife::GlesysBase

      banner "knife glesys server create (options)"

      deps do
        require 'fog'
        require 'readline'
        require 'chef/json_compat'
        require 'chef/knife/bootstrap'
        Chef::Knife::Bootstrap.load_deps
      end

      option :template,
        :short => "-t TEMPLATE",
        :long => "--template TEMPLATE",
        :description => "The template of the server (Debian 6.0 64-bit, Ubuntu, etc)",
        :proc => Proc.new { |f| Chef::Config[:knife][:template] = f }

      option :platform,
        :short => "-p PLATFORM",
        :long => "--platform PLATFORM",
        :description => "The platform to launch the server on (Xen or OpenVZ)",
        :proc => Proc.new { |f| Chef::Config[:knife][:platform] = f }

      option :datacenter,
        :short => "-d DATACENTER",
        :long => "--datacenter DATACENTER",
        :description => "The datacenter to launch the server in (Falkenberg, New York, Amsterdam or Stockholm)",
        :proc => Proc.new { |f| Chef::Config[:knife][:datacenter] = f }

      option :cpu_cores,
        :short => "-c CPUCORES",
        :long => "--cpu-cores CPUCORES",
        :description => "The number cpu cores (1-8)",
        :proc => Proc.new { |f| Chef::Config[:knife][:cores] = f }

      option :memory,
        :short => "-m MEMORY",
        :long => "--memory MEMORY",
        :description => "The amount of memory (128mb - 16384mb)",
        :proc => Proc.new { |f| Chef::Config[:knife][:memory] = f }

      option :memory,
        :short => "-m MEMORY",
        :long => "--memory MEMORY",
        :description => "The amount of memory (128mb - 16384mb)",
        :proc => Proc.new { |f| Chef::Config[:knife][:memory] = f }
    end
  end
end
