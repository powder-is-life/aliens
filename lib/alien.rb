# frozen_string_literal: true

require 'singleton'
class Alien
  include Singleton

  def ordered_detectable_pattern
    @ordered_detectable_pattern ||= looks.split
  end

  def looks
    raise NotImplementedError
  end
end
