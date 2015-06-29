require 'rails_helper'

describe Omit do
  describe ".omit?" do
    it "does not omit reply since only 2 can be potentially omitted, but we do no allow 3 or less omittions" do
      described_class.omit?(10, 8, 3).should == false
    end

    it "does not omit reply since only 2 can be potentially omitted, but we do no allow 2 or less omittions" do
      described_class.omit?(10, 8, 2).should == false
    end

    it "omits" do
      described_class.omit?(10, 7, 1).should == true
    end

    it "does not omit as total is equal to n_recent_only" do
      described_class.omit?(10, 10).should == false
    end

    it "does not omit as total is less than n_recent_only" do
      described_class.omit?(10, 20).should == false
    end
  end
end
