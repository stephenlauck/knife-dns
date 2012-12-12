

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
		class DnsZoneDelete < Knife

			include Knife::DnsBase

			banner "knife dns zone delete ZONE [ZONE] (options)"

			def run
			
				@name_args.each do |instance_id|
					begin
						zone_id = self.connection.zones.select{|z| z.domain =~ /#{instance_id}/}.first.id
						puts ui.color("Found zone id #{zone_id}", :cyan)

            zone = self.connection.zones.get(zone_id)
            puts ui.color("Found zone #{zone.domain}", :cyan)

            msg_pair("ID", zone.id)
            msg_pair("Domain", zone.domain)

            puts "\n"
            confirm("Do you really want to delete this zone?")

            zone.destroy

            ui.warn("Deleted zone #{zone.domain}")

          rescue NoMethodError
            ui.error("Could not locate zone '#{instance_id}'.")
            show_usage
          end
        end
			end
		end
	end
end
