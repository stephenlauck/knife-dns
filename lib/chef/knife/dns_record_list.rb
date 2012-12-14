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
    class DnsRecordList < Knife

      include Knife::DnsBase

      banner "knife dns record list ZONE (options)"

      def run

        records = [
          ui.color('Zone', :bold),
          ui.color('ID', :bold),
          ui.color('Record', :bold),
          ui.color('TTL', :bold),
          ui.color('Type', :bold),
          ui.color('Value', :bold),
        ]

        if name_args.size === 1
          
          zone = name_args.first

          self.connection.zones.get(zone).records.sort_by(&:name).each do |i|
            records << zone
            records << i.id.to_s
            records << "#{i.name}.#{zone}"
            records << i.ttl.to_s
            records << i.type
            records << i.value
          end
        else
          show_usage
          exit 1

          # show all records in all zones
          #  self.connection.zones.get(config[:zone]).records.sort_by(&:name).each do |i|
          #   records << config[:zone]
          #   records << i.id.to_s
          #   records << i.name
          # end

        end
        puts ui.list(records, :uneven_columns_across, 6)
      end
    end
  end
end
