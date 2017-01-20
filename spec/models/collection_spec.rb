require 'rails_helper'

RSpec.describe Collection, type: :model do

  it { should belong_to(:user).touch(true) }

end
