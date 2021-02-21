# frozen_string_literal: true

require 'spec_helper'
require 'squid'

RSpec.describe Squid do
  subject(:squid) { described_class.instance }

  describe '#looks' do
    it do
      expect { squid.looks }.not_to raise_error
    end

    it do
      expect(squid.looks.class).to eq String
    end
  end
end
