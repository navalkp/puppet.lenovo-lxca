################################################################################
# <LENOVO COPYRIGHT TO BE INSERTED>
#
# <The below Apache License information to be reviewed by legal
# and modified if need be>
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

describe Puppet::Type.type(:lxca_event).provider(:lxca_event) do

  before :each do
    described_class.stubs(:suitable?).returns true
    Puppet::Type.type(:lxca_event).stubs(:defaultprovider).returns described_class
  end

  let :event do
    Puppet::Type.type(:lxca_event).new(
      :name => 'lxca_event',
      :host => 'https://10.243.10.75',
      :port => '443',
      :login_user => 'Admin',
      :login_password => 'Lenovo123',
      :verify_ssl => 'NONE',
    )
  end
  
  describe "for discover_all" do
    it "should return an array as a result" do
      expect(event.provider.discover_all).to be_instance_of(Array)
    end
  end

end
