require 'spec_helper'
describe 'ompss' do

  context 'with defaults for all parameters' do
    it { should contain_class('ompss') }
  end
end
