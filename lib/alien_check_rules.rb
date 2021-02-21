# frozen_string_literal: true

require 'singleton'

class AlienCheckRules
  include Singleton

  def call(alien, width_of_the_input)
    {
      order_of_patterns: order_of_patterns(alien),
      amount_of_patterns: order_of_patterns(alien).length,
      offset_per_pattern: offset_per_pattern(alien, width_of_the_input)
    }
  end

  def offset_per_pattern(alien, width_of_the_input)
    result = {}
    order_of_patterns(alien).each_with_index do |pattern, index|
      result[pattern] = index * width_of_the_input
    end
    result
  end

  def order_of_patterns(alien)
    @order_of_patterns ||= alien.ordered_detectable_pattern
  end
end
