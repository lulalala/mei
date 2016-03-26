require 'rails_helper'

describe PostForm do
  let(:board){ FactoryGirl.create(:board) }

  let(:params){
    ActionController::Parameters.new(
      board_id: board.id,
      content: "hi"
    )
  }

  subject {
    subject = described_class.new.from_params(params)
  }

  describe "persistance" do
    context "opening new thread" do
      it "saves post with topic" do
        subject.save

        subject.post.persisted?.should == true
        subject.topic.persisted?.should == true
      end
    end

    context "opening new thread with image only" do
      let(:file){
        Rack::Test::UploadedFile.new(File.join(ActionController::TestCase.fixture_path, 'files/sample.jpg'), 'image/jpeg')
      }
      let(:params){
        ActionController::Parameters.new(
          board_id: board.id,
          images: [file]
        )
      }

      it "saves post with topic" do
        subject.save

        subject.post.persisted?.should == true
        subject.post.images.size.should == 1
        subject.topic.persisted?.should == true
      end
    end
  end

  describe "#new_topic?" do
    it "returns false if not persisted yet" do
      subject.new_topic?.should == true
    end

    it "returns true if persisted" do
      subject.save
      subject.new_topic?.should == false
    end
  end

  describe ".valid?" do
    context "topic is invalid" do
      before do
        subject.topic.stub(:valid?).and_return(false)
      end
      it "returns false" do
        subject.valid?.should == false
      end
    end

    context "post is invalid" do
      let(:params){
        ActionController::Parameters.new(
          board_id: board.id,
          content: "" # cause invalid
        )
      }
      it "returns false" do
        subject.valid?.should == false
        subject.errors[:base].present?.should == true
      end
    end

    context "topic and post are valid" do
      it "returns false" do
        subject.valid?.should == true
      end
    end

    context "called twice" do
      it "clears error object when called again" do
        subject.post.content = ""
        subject.valid?.should == false
        subject.post.content = "foo"
        subject.valid?.should == true
        subject.errors.empty?.should == true
      end
    end
  end
end
