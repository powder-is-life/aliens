require 'spec_helper'
require 'crab'

RSpec.describe Crab do
  subject(:crab) { described_class.instance }


  describe '#looks' do 
    it do
      expect { crab.looks } .not_to raise_error
    end

    it do
      expect(crab.looks.class).to eq String
    end
  end
end