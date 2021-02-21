require 'spec_helper'
require 'known_aliens_patterns'

RSpec.describe KnownAliensPatterns do
  subject(:service) { described_class.new(aliens) }


  context 'with aliens' do
    context 'with one alien' do
      let(:aliens) { [Crab.instance] }
      let(:expected_result) { Crab.instance.looks.split }

      it  do
        expect(service.call).to eq(expected_result)
      end
    end 
    
    context 'with more than one alien' do
      let(:aliens) { [Crab.instance, Squid.instance] }
      let(:expected_result) { Crab.instance.looks.split + Squid.instance.looks.split }
      
      it do
        expect(service.call).to eq(expected_result )
      end
    end
  end
  context 'with something else aliens' do
    let(:aliens) { [class SomeClass ; end] }
    let(:expected_result) { Crab.instance.looks.split }

    it  do
      expect { service.call } .to raise_error(NoMethodError)
    end
  end
end