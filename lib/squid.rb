
require 'alien'

class Squid < Alien 
  
  def looks
    <<~HEREDOC
      ---oo---
      --oooo--
      -oooooo-
      oo-oo-oo
      oooooooo
      --o--o--
      -o-oo-o-
      o-o--o-o
    HEREDOC
  end
end