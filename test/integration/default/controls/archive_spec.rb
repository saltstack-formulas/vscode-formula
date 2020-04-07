# frozen_string_literal: true

title 'vscode archives profile'

control 'vscode binary archive' do
  impact 1.0
  title 'should be installed'

  describe file('/usr/local/vscode-1.43.2/bin/code') do
    it { should exist }
  end
end
