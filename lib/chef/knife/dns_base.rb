#
# Author:: Stephen Lauck (<stephen.lauck@gmail.com>)
# Copyright:: Copyright (c) 2011-2012
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'chef/knife'

class Chef
  class Knife
    module DnsBase

      # :nodoc:
      # Would prefer to do this in a rational way, but can't be done b/c of
      # Mixlib::CLI's design :(
      def self.included(includer)
        includer.class_eval do

          deps do
            require 'fog'
            require 'readline'
            require 'chef/json_compat'
          end

          option :dns_provider,
            :short => "-P PROVIDER",
            :long => "--dns-provider PROVIDER",
            :description => "Your DNS Provider",
            :proc => Proc.new { |key| Chef::Config[:knife][:dns_provider] = key }


          option :dns_username,
            :short => "-A USERNAME",
            :long => "--dns-username USERNAME",
            :description => "Your DNS Username",
            :proc => Proc.new { |key| Chef::Config[:knife][:dns_username] = key }

          option :dns_password,
            :short => "-K PASSWORD",
            :long => "--dns-password PASSWORD",
            :description => "Your DNS Password",
            :proc => Proc.new { |key| Chef::Config[:knife][:dns_password] = key }
        end
      end

      def connection
        Chef::Log.debug("dns_username #{Chef::Config[:knife][:dns_username]}")

        provider = Chef::Config[:knife][:dns_provider]

        case provider
        when "local"
          @provider = provider
        else
          @connection ||= begin
            connection = Fog::DNS.new(
              :provider => provider,
              "#{provider.downcase}_email"    => Chef::Config[:knife][:dns_username],
              "#{provider.downcase}_password" => Chef::Config[:knife][:dns_password]
            )
          end
        end
      end

      def msg_pair(label, value, color=:cyan)
        if value && !value.to_s.empty?
          puts "#{ui.color(label, color)}: #{value}"
        end
      end

      def nsupdate(zone, record, ttl=86400, record_type, record_value)
        STDOUT.sync = true

        keyfile = Chef::Config[:knife][:dns_keyfile]
        server = Chef::Config[:knife][:dns_server]

        puts ui.color("keyfile: #{keyfile} server: #{server}", :cyan)

        IO.popen("/usr/bin/nsupdate -v -k #{keyfile}") do |f|
          # f << <<-EOD
          #   server #{server}
          #   zone #{zone}
          #   update delete #{record} #{record_type}
          #   update add #{record} #{ttl} #{record_type} #{record_value}
          #   show
          #   send
          #   quit
          # EOD

          # f.close_write
          # puts f.read

          f.puts "quit"
          f.close_write
          puts ui.color("#{f.gets}", :cyan)

        end
        # IO.popen("nsupdate -y #{DNS_INFO["key"]}:#{DNS_INFO["secret"]} -v", 'r+') do |f|
        #   f << <<-EOF
        #     server #{DNS_INFO["server"]}
        #     zone #{DNS_INFO["key"]}
        #     update delete #{HOSTNAME} A
        #     update add #{HOSTNAME} 60 A #{ip}
        #     show
        #     send
        #   EOF

        #   f.close_write
        #   puts f.read
        # end

      end
    end
  end
end

