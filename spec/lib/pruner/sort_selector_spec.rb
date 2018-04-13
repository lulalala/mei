# frozen_string_literal: true

require 'rails_helper'
describe Pruner::SortSelector do
  let(:board) { FactoryBot.create(:board) }

  subject { described_class.new(board, 3) }

  before do
    5.times do
      FactoryBot.create(:topic, board: board)
    end
  end

  let(:ids) { Topic.order(id: :asc).limit(2).pluck(:id) }
  it 'returns id' do
    expect(subject.perform).to match_array(ids)
  end
end
