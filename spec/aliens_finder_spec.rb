# frozen_string_literal: true

require 'spec_helper'
require 'aliens_finder'

RSpec.describe AliensFinder do
  let(:instance) { described_class.new }
  subject(:service) { instance.call(radar_output) }

  describe '#call' do
    let(:radar_output) do
      <<~HEREDOC
        --o-----o--
        ---o---o---
        --ooooooo--
        -oo-ooo-oo-
        ooooooooooo
        o-ooooooo-o
        o-o-----o-o
        ---oo-oo---
      HEREDOC
    end
    let(:expected_result) { { 'Crab' => [40], 'Squid' => [] } }
    let(:alien_matcher) { AlienMatcher.instance }
    let(:alien_finder_check) { AlienFinderCheck.instance }
    let(:matcher) { double(AhoCorasickMatcher) }

    before do
      allow(matcher).to receive(:match) { {} }
    end

    it do
      expect(alien_matcher)
        .to receive(:call)
        .and_return(matcher)

      expect(alien_finder_check)
        .to receive(:call)
        .with({}, 12)
        .and_return(expected_result)

      expect(service).to eq(expected_result)
    end
  end
end
