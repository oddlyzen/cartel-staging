require 'rails_helper'

RSpec.describe My::ProfilesController, type: :controller do

  let(:user) { create(:user) }

  before { login_user user }

  describe '#GET edit' do
    before { get :edit }

    it { is_expected.to render_template(:edit) }
    it { expect(assigns(:user)).to eq(user) }

  end

  describe '#PATCH update' do

    context 'with valid params' do

      before do
        patch :update, my_profile_form: {
          user_attributes: attributes_for(:user, tagline: 'Be Kind to One Another')
        }
      end

      it { expect(user.reload.tagline).to eq 'Be Kind to One Another' }
      it { is_expected.to redirect_to artist_path(user) }

    end

    context 'with invalid params' do

      before do
        patch :update, my_profile_form: {
          user_attributes: attributes_for(:user).merge(awards_attributes: { '0' => attributes_for(:award, :invalid) })
        }
      end

      it { expect(user.reload.email).not_to eq '' }
      it { is_expected.to redirect_to edit_my_profile_path }

    end

  end

end
