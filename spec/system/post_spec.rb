require "rails_helper"

RSpec.describe "Posting", js: true do
  let!(:board) { FactoryBot.create(:board) }

  let(:title) { "Test title" }
  let(:author) { "John Doe" }
  let(:email) { "test@test.com" }
  let(:content) { "Hello" }

  around do |example|
    perform_enqueued_jobs { example.run }
  end

  before do
    visit board_path(board)
  end

  it 'posts' do
# binding.pry
    fill_in 'post[title]', with: title
    fill_in 'post[author]', with: author
    fill_in 'post[options_raw]', with: email
    fill_in 'post[content]', with: content

    # perform_enqueued_jobs { click_on 'Create Post' }
    click_on 'Create Post'

# binding.pry
    expect(page).to have_content(content)


    # fill_in "Name", :with => "My Widget"
    # click_button "Create Widget"

    # expect(page).to have_text("Widget was successfully created.")
  end
end