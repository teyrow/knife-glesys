require "chef/knife"

class Chef
  class Knife
    module GlesysBase

      def self.included(includer)
        includer.class_eval do

          deps do
            require 'fog'
            require 'readline'
            require 'chef/json_compat'
          end

          option :glesys_api_key,
            :short => "-A KEY",
            :long => "--glesys-api-key KEY",
            :description => "Your Glesys API key",
            :proc => Proc.new { |key| Chef::Config[:knife][:glesys_api_key] = key }

          option :glesys_username,
            :short => "-U USERNAME",
            :long => "--glesys-username USERNAME",
            :description => "Your Glesysusername",
            :proc => Proc.new { |key| Chef::Config[:knife][:glesys_username] = key }
        end
      end

      def connection
        @connection ||= begin
          connection = Fog::Compute.new(
            :provider        => 'Glesys',
            :glesys_api_key  => Chef::Config[:knife][:glesys_api_key],
            :glesys_username => Chef::Config[:knife][:glesys_username],
          )
        end
      end

      def msg_pair(label, value, color=:cyan)
        if value && !value.to_s.empty?
          puts "#{ui.color(label, color)}: #{value}"
        end
      end

      def locate_config_value(key)
        key = key.to_sym
        config[key] || Chef::Config[:knife][key]
      end

      def color_state(state)

        return ui.color("unknown", :cyan) if state.nil?

        case state.to_s.downcase
          when 'shutting-down','terminated','stopping','stopped' then ui.color(state, :red)
          when 'pending', 'locked' then ui.color(state, :yellow)
          else ui.color(state, :green)
        end

      end

      def validate!
      end

    end
  end
end
