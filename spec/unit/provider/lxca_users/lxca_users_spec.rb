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

describe Puppet::Type.type(:lxca_users).provider(:lxca_users) do

  before :each do
    described_class.stubs(:suitable?).returns true
    Puppet::Type.type(:lxca_users).stubs(:defaultprovider).returns described_class
  end

  let :users do
    Puppet::Type.type(:lxca_users).new(
      :name => 'lxca_users',
      :host => 'https://10.243.10.75',
      :port => '443',
      :login_user => 'Admin',
      :login_password => 'Lenovo123',
      :verify_ssl => 'NONE',
    )
  end
  
  let :users_with_id do
    Puppet::Type.type(:lxca_users).new(
      :name => 'lxca_users',
      :host => 'https://10.243.10.75',
      :port => '443',
      :login_user => 'Admin',
      :login_password => 'Lenovo123',
      :verify_ssl => 'NONE',
      :id => '6610c3d3-ea89-4f12-8957-858dfc44f109'
    )
  end

  describe "provider instance type" do
    it "without id should be an instance of provider ruby" do
      expect(users.provider).to be_an_instance_of Puppet::Type.type(:lxca_users).provider(:lxca_users)
    end
    it "with id should be an instance of provider ruby" do
      expect(users_with_id.provider).to be_an_instance_of Puppet::Type.type(:lxca_users).provider(:lxca_users)
    end
  end

  describe "for ensurable filter_by_id" do
    it "should have id as a parameter" do
      expect {users.provider.filter_by_id}.to raise_error(Puppet::Error, /Attribute id is mandatory for the ensurable filter_by_id/)
    end
  end

  describe "for discover_all" do
    it "should return an array as a result" do
      expect(users.provider.discover_all).to be_instance_of(Array)
    end
  end

  describe "for filter_by_id" do
    it "should return an array as a result" do
      expect(users_with_id.provider.filter_by_id).to be_instance_of(Array)
    end
  end

end
