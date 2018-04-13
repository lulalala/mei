# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Board do
  describe '#config' do
    it 'uses global config as default' do
      Setting.dig('board')['foo'] = 1
      subject.config.dig(:foo).should eql(1)
    end
    it 'uses board config with higher precedence' do
      Setting.dig('board')['foo'] = 1
      subject.config.merge!({'foo' => 2})
      subject.config.dig(:foo).should eql(2)
    end
    it 'does not interfere with other board configs' do
      Setting.dig('board')['foo'] = 1

      board1 = FactoryBot.create(:board)
      board1.config.merge!('foo' => 7)

      board2 = FactoryBot.create(:board)

      board2.config.dig(:foo).should eql(1)

      board3 = FactoryBot.create(:board)
      board3.config.merge!('foo' => 9)

      board3.config.dig(:foo).should eql(9)
      board2.config.dig(:foo).should eql(1)
      board1.config.dig(:foo).should eql(7)
    end
  end
end
