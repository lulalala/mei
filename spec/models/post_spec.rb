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
end
