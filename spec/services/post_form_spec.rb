# frozen_string_literal: true

require 'rails_helper'

describe PostForm do
  let(:board) { FactoryBot.create(:board) }

  let(:params)  do
    ActionController::Parameters.new(
      board_id: board.id,
      content: 'hi'
    )
  end

  subject do
    subject = described_class.new.from_params(params)
  end

  describe 'persistance' do
    context 'opening new thread' do
      it 'saves post with topic' do
        subject.save

        subject.post.persisted?.should eql(true)
        subject.topic.persisted?.should eql(true)
      end
    end

    context 'opening new thread with image only' do
      let(:file) do
        Rack::Test::UploadedFile.new(File.join(ActionController::TestCase.fixture_path, 'files/sample.jpg'), 'image/jpeg')
      end
      let(:params) do
        ActionController::Parameters.new(
          board_id: board.id,
          images: [file]
        )
      end

      it 'saves post with topic' do
        subject.save

        subject.post.persisted?.should eql(true)
        subject.post.images.size.should eql(1)
        subject.topic.persisted?.should eql(true)
      end
    end
  end

  describe '#new_topic?' do
    it 'returns false if not persisted yet' do
      subject.new_topic?.should eql(true)
    end

    it 'returns true if persisted' do
      subject.save
      subject.new_topic?.should eql(false)
    end
  end

  describe '.valid?' do
    context 'topic is invalid' do
      before do
        subject.topic.stub(:valid?).and_return(false)
      end
      it 'returns false' do
        subject.valid?.should eql(false)
      end
    end

    context 'post is invalid' do
      let(:params) do
        ActionController::Parameters.new(
          board_id: board.id,
          content: '' # cause invalid
        )
      end
      it 'returns false' do
        subject.valid?.should eql(false)
        subject.errors.adequate.messages.present?.should eql(true)
      end
    end

    context 'topic and post are valid' do
      it 'returns false' do
        subject.valid?.should eql(true)
      end
    end

    context 'called twice' do
      it 'clears error object when called again' do
        subject.post.content = ''
        subject.valid?.should eql(false)
        subject.post.content = 'foo'
        subject.valid?.should eql(true)
        subject.errors.empty?.should eql(true)
      end
    end
  end
end
