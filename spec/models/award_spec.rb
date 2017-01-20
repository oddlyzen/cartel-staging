require 'rails_helper'

RSpec.describe Award, type: :model do
  it { should belong_to(:user).touch(true) }

  it { should validate_presence_of :title }
  it { should validate_presence_of :year }
end
