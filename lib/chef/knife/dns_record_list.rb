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

      banner "knife dns record list (options)"

      option :zone,
          :short => "-Z ZONE",
          :long => "--zone ZONE",
          :description => "Zone for the record"

      def run
        unless config[:zone]
          ui.error("You have not provided a zone")
          show_usage
          exit 1
        end

        records = [
          ui.color('ID', :bold),
          ui.color('Name', :bold),
        ]

        self.connection.zones.get(config[:zone]).records.sort_by(&:name).each do |i|
          records << i.id.to_s
          records << i.name
        end

        puts ui.list(records, :uneven_columns_across, 2)
      end
    end
  end
end
