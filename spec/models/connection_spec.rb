require 'rails_helper'

RSpec.describe Connection, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:friend).with_foreign_key('friend_id') }

  it { should validate_presence_of :friend }
  it { should validate_presence_of :user }
  it { should validate_uniqueness_of(:user_id).scoped_to(:friend_id) }

end
