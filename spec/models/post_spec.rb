require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    subject.stub(:board) { FactoryGirl.create(:board) }
  end
  describe '#options_raw=' do
    it 'analyze value' do
      subject.options_raw = 'sage sg-epk@jtk93.x29.jp'
      subject.options.should include 'sage'
      subject.email.should include 'sg-epk@jtk93.x29.jp'
    end

    it 'can handle empty string' do
      subject.options_raw = ''
      expect(subject.options.empty?).to eq(true)
    end
  end

  describe 'reply' do
    let!(:board) { FactoryGirl.create(:board) }
    let!(:topic) { FactoryGirl.create(:topic, board:board)}
    let!(:post1) { FactoryGirl.create(:post, topic:topic, content:'first post')}

    it do
      post2 = Post.create(topic: topic, content: "> 1 foo")
      post3 = Post.create(topic: topic, content: "> 1\n > 2 bar")

      expect(post2.parents).to contain_exactly(post1)
      expect(post3.parents).to contain_exactly(post1, post2)

      expect(post1.children).to contain_exactly(post2, post3)
      expect(post2.children).to contain_exactly(post3)
    end

    describe '#turn_reply_to_link' do
      it "convert reference to link" do
        post2 = Post.create(topic: topic, content: "> 1 foo")

        expect(post2.content_html).to include(%{<a href="/#{board.seo_name}/topics/#{topic.id}##{post1.presenter.dom_id}">&gt; 1</a> foo})

        # test for position over 10
        topic.update_column(:max_pos, 42)
        post2.update_column(:pos, 42)

        post3 = Post.create(topic: topic, content: "> 42 foo")

        expect(post3.content_html).to include(%{<a href="/#{board.seo_name}/topics/#{topic.id}##{post2.presenter.dom_id}">&gt; 42</a> foo})
      end
    end
  end
end
