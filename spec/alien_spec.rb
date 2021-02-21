require 'spec_helper'
require 'alien'

RSpec.describe Alien do
  subject(:alien) { described_class.instance }


  describe '#looks' do 
    it do
      expect { alien.looks } .to raise_error(NotImplementedError)
    end
  end
end