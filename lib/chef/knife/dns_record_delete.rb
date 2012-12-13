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
    class DnsRecordDelete < Knife

      include Knife::DnsBase

      banner "knife dns record delete RECORD [RECORD] -Z ZONE (options)"

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

        @name_args.each do |instance_id|
          begin

           record = self.connection.zones.get(config[:zone]).records.select{|r| r.name =~ /#{instance_id}/}.first

            msg_pair("Zone", record.zone.domain)
            msg_pair("ID", record.id)
            msg_pair("Record", record.name)

            puts "\n"
            confirm("Do you really want to delete this record?")

            record.destroy

            ui.warn("Deleted record #{record.name}")

          rescue NoMethodError
            ui.error("Could not locate record '#{instance_id}'.")
            show_usage
          end
        end
      end
    end
  end
end
