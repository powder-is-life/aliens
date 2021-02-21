# frozen_string_literal: true

require 'alien_finder_check'
require 'alien_matcher'

class AliensFinder
  def initialize
    @matcher = prepare_matcher
  end

  def call(input)
    patterns_found = search_for_known_aliens(input)
    width_to_consider = input_width(input)
    analyze_results(patterns_found, width_to_consider)
  end

  private

  def input_width(input)
    input.lines.first.length
  end

  def analyze_results(results, width_to_consider)
    AlienFinderCheck.instance.call(results, width_to_consider)
  end

  def search_for_known_aliens(input)
    @matcher.match(input)
  end

  def prepare_matcher
    @prepare_matcher ||= AlienMatcher.instance.call
  end
end
