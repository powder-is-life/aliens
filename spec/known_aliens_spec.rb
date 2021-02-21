require 'spec_helper'
require 'known_aliens'

RSpec.describe KnownAliens do
  subject(:service) { described_class.instance }


  context 'with aliens' do
    context 'with more than one alien' do
      let(:expected_result) { [Squid.instance, Crab.instance] }
      
      it do
        expect(service.call).to eq(expected_result)
      end
    end
  end
end