require 'awspec'

control 'vpc' do
  describe 'the vpc' do
    subject { vpc 'kitchen-terraform demo - Erwin' }
    it do
      should exist
      should be_available
    end
    its('cidr_block') { should eq '10.1.0.0/16' }
  end
end

control 'subnet' do
  describe 'the subnet' do
    subject { subnet 'kitchen-terraform demo - Erwin' }
    it do
      should exist
      should be_available
    end
    its('cidr_block') { should eq '10.1.1.0/24' }
  end
end

control 'sg' do
  describe 'the security group' do
    subject { security_group 'kitchen-terraform demo - Erwin' }
    it { should exist }
    its('inbound') { should be_opened(22) }
  end
end
