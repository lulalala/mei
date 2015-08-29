require 'rails_helper'
describe Pruner::SortSelector do
  let(:board){ FactoryGirl.create(:board) }

  subject { described_class.new(board, 3)}

  before do
    5.times do
      FactoryGirl.create(:topic, board: board)
    end
  end

  it "returns id" do
    subject.perform.should == Topic.order(id: :asc).limit(2).pluck(:id)
  end
end
