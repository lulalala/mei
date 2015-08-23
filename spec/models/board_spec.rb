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
  end
end
