# frozen_string_literal: true

require 'alien'

class Crab < Alien
  def looks
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
end
