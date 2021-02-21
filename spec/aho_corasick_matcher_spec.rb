require 'spec_helper'
require 'aho_corasick_matcher'

RSpec.describe AhoCorasickMatcher do
  subject(:matcher) { described_class.new(dict) }

  context 'with an empty dictionary' do
    let(:dict) { [] }

    it 'finds no strings' do
      expect(matcher.match('I am a test string')).to be_empty
    end
  end

  context 'with a single-entry dictionary' do
    let(:dict) { %w(TestString) }

    it 'finds matching strings' do
      expect(matcher.match('I am a TestString')).to eq( { "TestString" => [17] } )
    end

    it 'does not find non-matching strings' do
      expect(matcher.match('I am a different string')).to be_empty
    end

    it 'finds all occurrences of strings' do
      expect(
        matcher.match('I am a TestString and I say TestString twice')
      ).to eq( { "TestString" => [17, 38] } )
    end
  end

  context 'with a multiple-entry dictionary' do
    let(:dict) { %w(TestString1 TestString2) }

    it 'finds all matching strings' do
      expect(
        matcher.match('I am both a TestString1 and a TestString2')
      ).to eq( { "TestString1" => [23], "TestString2" => [41] } )
    end

    it 'finds partial matching strings' do
      expect(
        matcher.match('I am a TestString1 but do not contain the other one')
      ).to eq( { "TestString1" => [18] } )
    end

    it 'does not find non-matching strings' do
      expect(matcher.match('I am a different string')).to be_empty
    end
  end

  context 'with a multiple-entry dictionary including prefixes' do
    let(:dict) { %w(TestString TestStringExtended) }

    it 'finds all matching strings' do
      expect(
        matcher.match('I contain TestStringExtended')
      ).to eq( { "TestString" => [20], "TestStringExtended" => [28] } )
    end

    it 'finds partial matching strings' do
      expect(
        matcher.match('I am a TestString but do not contain the other one')
      ).to eq( { "TestString" => [17] } )
    end

    it 'does not find non-matching strings' do
      expect(matcher.match('I am a different string')).to be_empty
    end
  end

  context 'with an overlapping dictionary' do
    let(:dict) { %w(Test String TestString) }

    it 'finds all matching strings' do
      expect(
        matcher.match('TestStringTest')
      ).to eq( { "Test" => [4,14], "String" => [10],"TestString" => [10] } )
    end
  end

  describe '#inspect' do
    let(:dict) { ('aaa'...'bbb').to_a }

    it 'does not include instance variables to prevent stack explosions' do
      expect(matcher.inspect).not_to include('@child_map')
    end
  end
end