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

require 'spec_helper'

describe Puppet::Type.type(:lxca_discovery).provider(:lxca_discovery) do

  before :each do
    described_class.stubs(:suitable?).returns true
    Puppet::Type.type(:lxca_discovery).stubs(:defaultprovider).returns described_class
  end

  let :discovery do
    Puppet::Type.type(:lxca_discovery).new(
      :name => 'lxca_discovery',
      :host => 'https://10.240.29.217',
      :port => '443',
      :login_user => 'USERID',
      :login_password => 'Passw0rd',
      :verify_ssl => 'NONE',
    )
  end

  describe "provider instance type" do
    it "should be an instance of provider ruby" do
      expect(discovery.provider).to be_an_instance_of Puppet::Type.type(:lxca_discovery).provider(:lxca_discovery)
    end
  end

  describe "for discover_devices_by_slp" do
    it "should return an array as a result" do
      expect(discovery.provider.discover_devices_by_slp).to be_instance_of(Array)
    end
  end

end
