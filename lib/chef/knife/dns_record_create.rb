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

require 'chef/knife/dns_base'

class Chef
  class Knife
    class DnsRecordCreate < Knife

      include Knife::DnsBase

      banner "knife dns record create -N NAME -T TYPE -i VALUE -Z ZONE (options)"

      option :zone,
        :short => "-Z ZONE",
        :long => "--zone ZONE",
        :description => "Zone for the record"

      option :name,
        :short => "-N NAME",
        :long => "--name NAME",
        :description => "Name for the record"

      option :type,
        :short => "-T TYPE",
        :long => "--type TYPE",
        :description => "Type of record"

      option :value,
        :short => "-i VALUE",
        :long => "--value VALUE",
        :description => "Value for the record"

      def run
        
        unless config[:zone]
          ui.error("You have not provided a zone to create record in")
          show_usage
          exit 1
        end

        if self.connection == 'local'
          zone = config[:zone]
          record = config[:name]
          record_type = config[:type]
          record_value = config[:value]

          nsupdate(zone, record, 86400, record_type, record_value)
        else
          # zone_id = self.connection.zones.select{|z| z.domain =~ /#{config[:zone]}/}.first.id
          zone = self.connection.zones.get(config[:zone])
          puts ui.color("Adding record to #{zone.domain} #{zone.id}", :cyan)
        end

        record = zone.records.create({
          :name => config[:name],
          :type => config[:type],
          :value => config[:value]
        })

        puts ui.color("Created record:", :cyan)
        msg_pair("ID", record.id.to_s)
        msg_pair("Zone", zone.domain)
        msg_pair("Name", record.name)
        msg_pair("Value", record.value)

      end
    end
  end
end
