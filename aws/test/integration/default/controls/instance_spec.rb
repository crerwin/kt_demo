control 'operating_system' do
  describe command('lsb_release -a') do
    its('stdout') { should match (/Ubuntu/) }
  end
end

control 'open_ports' do
  describe port(80) do
    it { should_not be_listening }
  end

  describe port(22) do
    it { should be_listening }
  end
end

control 'internet_access' do
  describe host('8.8.8.8', proto: 'icmp') do
    it { should be_reachable }
  end
end
