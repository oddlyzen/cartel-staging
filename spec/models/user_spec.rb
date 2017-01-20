require 'rails_helper'

RSpec.describe User, type: :model do

  subject { build(:user) }

  it { should have_one(:profile) }

  it { should have_many(:authentications) }

  it { should have_many(:companies).with_foreign_key('owner_id') }
  it { should have_many(:company_memberships) }
  it { should have_many(:joined_companies) }

  it { should have_many(:artworks) }
  it { should have_many(:series) }
  it { should have_many(:educations) }
  it { should have_many(:awards) }
  it { should have_many(:bibliographies) }
  it { should have_many(:residencies) }
  it { should have_many(:experiences) }
  it { should have_many(:publications) }
  it { should have_many(:collections) }
  it { should have_many(:memberships) }
  it { should have_many(:participations) }
  it { should have_many(:exhibitions) }
  it { should have_many(:media_features) }

  it { should have_many(:connections) }
  it { should have_many(:passive_connections).with_foreign_key('friend_id') }

  it { should have_many(:active_friends).through(:connections) }
  it { should have_many(:passive_friends).through(:passive_connections) }
  it { should have_many(:pending_friends).through(:connections) }
  it { should have_many(:pending_passive_friends).through(:passive_connections) }
  it { should have_many(:rejected_friends).through(:connections) }
  it { should have_many(:rejected_passive_friends).through(:passive_connections) }

  it { should have_many(:artwork_collaborators) }
  it { should have_many(:collaborated_artworks).through(:artwork_collaborators) }
  it { should have_many(:pending_collaborations).through(:artwork_collaborators) }

  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :title }
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :profile }

    context 'for new record' do
      context 'with nil password' do
        subject { build(:user, password: nil, password_confirmation: nil) }
        it { is_expected.to be_valid }
      end

      context 'with blank (empty string) password' do
        subject { build(:user, password: '', password_confirmation: '') }
        it { is_expected.not_to be_valid }
      end
    end

  end

end
