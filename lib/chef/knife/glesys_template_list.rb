require "chef/knife/glesys_base"

class Chef
  class Knife
    class GlesysTemplateList < Knife
      include Knife::GlesysBase

      banner "knife glesys template list (options)"

      deps do
        require 'fog'
        require 'readline'
        Chef::Knife::Bootstrap.load_deps
      end

      def run

        template_list = [
          ui.color('Platform', :bold),
          ui.color('Name', :bold),
          ui.color('Operating System', :bold),
          ui.color('Min Memory Size', :bold),
          ui.color('Min Disk Size', :bold),

        ]

        connection.templates.sort_by(&:platform).each do |template|
          template_list << template.platform
          template_list << template.name
          template_list << template.operating_system
          template_list << "#{template.minimum_memory_size} mb"
          template_list << "#{template.minimum_disk_size} gb"
        end

        puts ui.list(template_list, :columns_across, 5)
      end
    end
  end
end
