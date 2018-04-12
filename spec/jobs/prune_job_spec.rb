# frozen_string_literal: true

require 'rails_helper'
describe PruneJob do
  let(:board) { FactoryBot.create(:board) }

  let(:config_overrides) do
    {
      'pagination' => {
        'per_page' => 2,
        'max_page' => 2
      },
      'prune' => {
        'selector_class' => 'SortSelector',
        'selector_options' => {},
        'remover_class' => 'DestroyRemover',
        'remover_options' => {}
      }
    }
  end

  before do
    perform_enqueued_jobs do
      5.times do
        FactoryBot.create(:topic, board: board)
      end
    end

    board.config.merge!(config_overrides)
  end

  it 'prunes topics so there are only 2 pages left' do
    described_class.new.perform(board)
    board.topics.count.should eql(4)
  end
end
