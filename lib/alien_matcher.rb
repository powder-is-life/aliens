require 'aho_corasick_matcher'
require 'known_aliens_patterns'
require 'singleton'

class AlienMatcher 
  include Singleton

  def call
    prepare_matcher
  end

  def prepare_matcher
    AhoCorasickMatcher.new(known_aliens_patterns)
  end

  def known_aliens_patterns
    KnownAliensPatterns.instance.call(known_aliens)
  end

  def known_aliens
    KnownAliens.instance.call
  end
end