require 'known_aliens'
require 'singleton'

class KnownAliensPatterns
  include Singleton

  def call(known_aliens)
    known_aliens_patterns(known_aliens)
  end 

  private

  def known_aliens_patterns(known_aliens)
    known_aliens.map(&:ordered_detectable_pattern).flatten
  end
end