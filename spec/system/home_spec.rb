require "rails_helper"

RSpec.describe 'Home' do
  let!(:board1) { FactoryBot.create(:board) }
  let!(:board2) { FactoryBot.create(:board) }

  before do
    visit home_path
  end

  it 'shows boards' do
    expect(page).to have_content(board1.name)
    expect(page).to have_content(board1.seo_name)

    expect(page).to have_content(board2.name)
    expect(page).to have_content(board2.seo_name)
  end
end