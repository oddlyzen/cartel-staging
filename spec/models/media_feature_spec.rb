require 'rails_helper'

RSpec.describe MediaFeature, type: :model do

  it { should belong_to(:user).touch(true) }

end
