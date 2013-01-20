require "chef/knife/glesys_base"

class Chef
  class Knife
    class GlesysTemplateList < Knife
      include Knife::GlesysBase

      banner "knife glesys template list (options)"

      def run

        template_list = [
          ui.color('ID', :bold),
          ui.color('Platform', :bold),
          ui.color('Name', :bold),
          ui.color('OS', :bold),
          ui.color('Min Memory', :bold),
          ui.color('Min Disk', :bold),
        ]

        connection.templates.sort_by(&:templateid).each do |template|
          template_list << template.templateid.to_s
          template_list << template.platform
          template_list << template.name
          template_list << template.os
          template_list << template.min_mem_size
          template_list << template.min_disk_size
        end

        puts ui.list(template_list, :columns_across, 6)
      end
    end
  end
end
