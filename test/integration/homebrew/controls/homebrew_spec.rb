# frozen_string_literal: true

title 'code archives profile'

control 'code source archive' do
  impact 1.0
  title 'should be installed'

  describe file('/opt/local/bin/code') do
    it { should exist }
  end
end
