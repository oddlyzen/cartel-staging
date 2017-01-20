require 'rails_helper'

RSpec.describe FeedItemDecorator, type: :decorator do

  let(:feed_item) { create(:feed_item) }
  subject { described_class.new(feed_item) }

  describe '#user_name' do
    it { expect(subject.user_name).to eq("#{feed_item.user.first_name} #{feed_item.user.last_name}") }
  end

  describe '#time' do
    it { expect(subject.time).to eq(feed_item.created_at.strftime('%e %b, %l:%M%P')) }
  end

end
