require 'rails_helper'

RSpec.describe FeedItem, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:artwork) }
  it { should belong_to(:resource) }

  describe 'validations' do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:kind) }

    context 'when type is new_series_artwork' do
      subject { build(:feed_item, :new_series_artwork) }
      it { should validate_presence_of(:artwork) }
    end

    context 'when type is series_published' do
      subject { build(:feed_item, :series_published) }
      it { should validate_presence_of(:resource) }
    end

    context 'when type is not new_series_artwork' do
      subject { build(:feed_item, :user_update) }
      it { should_not validate_presence_of(:artwork) }
    end
  end
end
