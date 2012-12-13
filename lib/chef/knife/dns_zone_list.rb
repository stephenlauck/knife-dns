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
		class DnsZoneList < Knife

			include Knife::DnsBase

			banner "knife dns zone list (options)"

			def run
				domains = [
				  ui.color('ID', :bold),
				  ui.color('Domain', :bold),
 				  ui.color('Nameservers', :bold)
				]

				self.connection.zones.sort_by(&:domain).each do |i|
				  domains << i.id.to_s
				  domains << i.domain
				  domains << i.nameservers.join( ' ' )
				end

				puts ui.list(domains, :uneven_columns_across, 3)
			end
		end
	end
end