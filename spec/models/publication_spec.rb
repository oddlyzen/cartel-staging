require 'rails_helper'

RSpec.describe Publication, type: :model do

  it { should belong_to(:user).touch(true) }

end
