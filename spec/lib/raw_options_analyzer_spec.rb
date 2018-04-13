# frozen_string_literal: true

require 'rails_helper'

describe RawOptionsAnalyzer do
  describe '#email' do
    it 'extracts single email' do
      described_class.new('foobar@example.com', []).email.should eql('foobar@example.com')
      described_class.new('232323232323@BLUERADI.co.jp', []).email.should eql('232323232323@BLUERADI.co.jp')
      described_class.new('administration@example.museum', []).email.should eql('administration@example.museum')
    end

    it 'extracts email from a few tokens' do
      described_class.new('sage akira@gmail.com fuge dage', []).email.should eql('akira@gmail.com')
    end

    it 'returns nil if no emails can be found' do
      described_class.new('this is a pen', []).email.should.nil?
    end

    it 'returns nil if options field is empty' do
      described_class.new(nil, []).email.should.nil?
      described_class.new('', []).email.should.nil?
    end
  end

  describe '#options' do
    it 'returns tokens matching available options' do
      described_class.new('sage foo@example.com', ['sage']).options.should eql(['sage'])
    end

    it 'returns empty array if nothing in raw options matches' do
      described_class.new('sega', ['sage']).options.should eql([])
    end
  end
end
