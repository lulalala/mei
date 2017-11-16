require 'rails_helper'
describe PruneJob do
  let(:board) { FactoryBot.create(:board) }

  before do
    5.times do
      FactoryBot.create(:topic, board: board)
    end

    board.stub(:config) {
      Settingslogic.new({
        'pagination' => {
          'per_page' => 2,
          'max_page' => 2
        },
        'prune' => {
          'selector_class' => "SortSelector",
          'selector_options' => {},
          'remover_class' => "DestroyRemover",
          'remover_options' => {},
        }
      })
    }
  end

  it "prunes topics so there are only 2 pages left" do
    described_class.new.perform(board)
    board.topics.count.should == 4
  end
end
