require 'rails_helper'

RSpec.describe Board, type: :model do
  describe "#config" do
    it "uses global config as default" do
      AppConfig['board']['foo'] = 1
      subject.config[:foo].should == 1
    end
    it "uses board config with higher precedence" do
      AppConfig['board']['foo'] = 1
      subject.config = {'foo' => 2}
      subject.config[:foo].should == 2
    end
    it "does not interfere with other board configs" do
      AppConfig['board']['foo'] = 1

      board1 = FactoryBot.create(:board, config: {'foo' => 7})
      board2 = FactoryBot.create(:board)

      board2.config[:foo].should == 1

      board3 = FactoryBot.create(:board, config: {'foo' => 9})

      board3.config[:foo].should == 9
      board2.config[:foo].should == 1
      board1.config[:foo].should == 7
    end
  end
end
