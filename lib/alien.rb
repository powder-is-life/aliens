
require 'singleton'
class Alien
  include Singleton
  
  def ordered_detectable_pattern
    @patterns ||= looks.split
  end

  def looks
    raise NotImplementedError
  end
end