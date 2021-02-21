require 'spec_helper'
require 'alien_matcher'

RSpec.describe AlienMatcher do
  let(:instance) { described_class.instance }
  subject(:service) { instance.call }


  describe '#call' do

    let(:expected_result) { "Voila"}
    let(:known_aliens) { KnownAliens.instance }
    let(:known_aliens_patterns) { KnownAliensPatterns.instance }


    before do 
      
      allow(AhoCorasickMatcher)
        .to receive(:new)
        .and_return(expected_result)      

    end

    it  do
      expect(known_aliens)
        .to receive(:call)
        .and_return("SOMEALIEN")
        expect(known_aliens_patterns)
        .to receive(:call)
        .with("SOMEALIEN")
        .and_return("CHOPPED")
      expect(service).to eq(expected_result)
    end
  end
end