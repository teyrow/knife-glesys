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
          ui.color('Template Name', :bold),
        ]

        connection.templates.sort_by(&:templateid).each do |template|
          template_list << template.platform
          template_list << template.name
        end

        puts ui.list(template_list, :columns_across, 2)
      end
    end
  end
end
