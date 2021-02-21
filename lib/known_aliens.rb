# frozen_string_literal: true

require 'crab'
require 'squid'
require 'singleton'

class KnownAliens
  include Singleton

  def call
    [Squid.instance, Crab.instance]
  end
end
