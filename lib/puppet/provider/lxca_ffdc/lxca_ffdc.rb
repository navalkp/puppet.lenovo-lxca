################################################################################
# Lenovo Copyright
#
# (c) Copyright Lenovo 2016.
#
# LIMITED AND RESTRICTED RIGHTS NOTICE:
# If data or software is delivered pursuant a General Services
# Administration (GSA) contract, use, reproduction, or disclosure
# is subject to restrictions set forth in Contract No. GS-35F-05925.
#-------------------------------------------------------------
#
# Licensed under the Apache License, Version 2.0 (the "License");
# You may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
################################################################################

require 'xclarity_client'

Puppet::Type.type(:lxca_ffdc).provide(:lxca_ffdc) do
  desc 'Ffdc provider for LXCA resource'
  
  def create_client
    conf=XClarityClient::Configuration.new(
      :username => @resource['login_user'],
      :password => @resource['login_password'],
      :host => @resource['host'],
      :port => @resource['port'],
      :auth_type => @resource['auth_type'],
      :verify_ssl => @resource['verify_ssl']
    )
    @client = XClarityClient::Client.new(conf)
  end

  def exists?
    return if @client.nil?
  end

  def create
    create_client
  end

  def destroy
    @client = nil
  end

  def filter_by_uuid
    create_client if @client.nil?
    if @resource[:uuid].nil?
      raise Puppet::Error, _("Attribute uuid is mandatory for the ensurable filter_by_uuid")
    end

    @client.fetch_ffdc(["#{@resource[:uuid]}"]).map do |ffdc|
      ffdc.instance_variables.each do |att|
        puts "#{att} - #{ffdc.instance_variable_get att}"
      end
    end
  end

end

