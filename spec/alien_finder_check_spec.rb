require 'spec_helper'
require 'alien_finder_check'

RSpec.describe AlienFinderCheck do
  let(:instance) { described_class.instance }
  let(:width_of_the_input) { 11 }

  subject(:service) { instance.call(results_from_search, width_of_the_input) }

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
    let(:expected_check_result) do
      {
        order_of_patterns: expected_order_of_patterns,
        amount_of_patterns: expected_order_of_patterns.length,
        offset_per_pattern: expected_offset_per_pattern
      }
    end

    let(:alien_check_rules) { AlienCheckRules.instance }
    let(:known_aliens) { KnownAliens.instance }
    let(:expected_aliens) do
      [Class.new]
    end
    

    context "when there is a match" do 
      let(:results_from_search) do 
        {
          '--o-----o--' => [3],
          '---o---o---' => [14],
          '--ooooooo--' => [25]
        }
      end 
      let(:expected_result) { [ { "Class" => [3] } ] }

      it do
        expect(known_aliens)
          .to receive(:call)
          .and_return(expected_aliens)
  
        expect(alien_check_rules)
          .to receive(:call)
          .with(expected_aliens.first ,width_of_the_input)
          .and_return(expected_check_result)
          
        expect(service).to eq(expected_result)
      end

    end    
    
    context "when there is no match" do 
      let(:results_from_search) do 
        {
          '--o-----o--' => [3],
          '---o---o---' => [14],
          '--ooooooo--' => [26]
        }
      end 

      let(:expected_result) { [ { "Class" => [] } ] }
      it do
        expect(known_aliens)
          .to receive(:call)
          .and_return(expected_aliens)
  
        expect(alien_check_rules)
          .to receive(:call)
          .with(expected_aliens.first ,width_of_the_input)
          .and_return(expected_check_result)
          
        expect(service).to eq(expected_result)
      end
    end
  end
end