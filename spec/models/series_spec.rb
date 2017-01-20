require 'rails_helper'

RSpec.describe Series, type: :model do

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:artwork) }
  it { is_expected.to belong_to(:exhibition) }

  it { is_expected.to have_many(:artworks) }

  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of(:description).on(:publish) }
  it { is_expected.to validate_presence_of(:year).on(:publish) }

  it { is_expected.to define_enum_for(:status).with([:unpublished, :published]) }

end
