require 'known_aliens'
require 'alien_check_rules'
require 'singleton'

class AlienFinderCheck
  include Singleton

  def call(results_from_search, width_of_the_input)
    known_aliens.map do |alien|
      alien_check_rule = AlienCheckRules.instance.call(alien, width_of_the_input)
      first_pattern = alien_check_rule[:order_of_patterns].first

      next { alien.class.to_s => [] } unless results_from_search.key?(first_pattern)
      
      current_matches =  results_from_search[first_pattern].dup
      alien_check_rule[:order_of_patterns][1..].map do |pattern|
        next_pattern_matches = results_from_search[pattern].map do |ocurrence_location| 
          ocurrence_location -  alien_check_rule[:offset_per_pattern][pattern]
        end
        current_matches = current_matches & next_pattern_matches
        if current_matches.empty?
          break
        end
      end
      
      { alien.class.to_s => current_matches }
    end
  end

  def known_aliens 
    KnownAliens.instance.call
  end
end