# frozen_string_literal: true

require 'spec_helper'
require 'alien_check_rules'
require 'alien'

RSpec.describe AlienCheckRules do
  let(:alien) { double(Alien) }
  let(:instance) { described_class.instance }
  let(:width_of_the_input) { 11 }
  subject(:service) { instance.call(alien, width_of_the_input) }

  describe '#call' do
    let(:looks_example) do
      <<~HEREDOC
        --o-----o--
        ---o---o---
        --ooooooo--
      HEREDOC
    end
    let(:expected_order_of_patterns) do
      [
        '--o-----o--',
        '---o---o---',
        '--ooooooo--'
      ]
    end

    let(:expected_offset_per_pattern) do
      {
        '--o-----o--' => 0,
        '---o---o---' => width_of_the_input * 1,
        '--ooooooo--' => width_of_the_input * 2
      }
    end
    let(:expected_result) do
      {
        order_of_patterns: expected_order_of_patterns,
        amount_of_patterns: expected_order_of_patterns.length,
        offset_per_pattern: expected_offset_per_pattern
      }
    end

    let(:matcher) { double(AhoCorasickMatcher) }

    before do
      allow(alien).to receive(:ordered_detectable_pattern) do
        looks_example.split
      end
    end

    it do
      expect(service).to eq(expected_result)
    end
  end
end
