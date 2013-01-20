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
        Fog.mock!
        @connection ||= begin
          connection = Fog::Compute.new(
            :provider        => 'Glesys',
            :glesys_api_key  => Chef::Config[:knife][:glesys_api_key],
            :glesys_username => Chef::Config[:knife][:glesys_username],
          )
        end
      end

      def validate!
      end

    end
  end
end
