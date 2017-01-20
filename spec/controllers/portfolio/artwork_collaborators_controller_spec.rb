require 'rails_helper'

RSpec.describe Portfolio::ArtworkCollaboratorsController, type: :controller do
  let(:user) { create(:user, :artist) }
  let(:collaboration) { create(:artwork_collaborator, collaborator: user, status: collaboration_status) }

  before { login_user user }

  describe 'PATCH #approve' do
    before { patch :accept, id: collaboration }

    context 'with valid params' do
      let(:collaboration_status) { :pending }
      it { expect(collaboration.reload.accepted?).to be true }
      it { is_expected.to redirect_to root_path }
    end

    context 'with invalid params' do
      let(:collaboration_status) { :rejected }

      it { expect(collaboration.reload.accepted?).to be false }
      it { is_expected.to redirect_to root_path }
    end

  end

  describe 'PATCH #reject' do

    before { patch :reject, id: collaboration }

    context 'with valid params' do
      let(:collaboration_status) { :pending }

      it { expect(collaboration.reload.rejected?).to be true }
      it { is_expected.to redirect_to root_path }
    end

    context 'with invalid params' do
      let(:collaboration_status) { :accepted }

      it { expect(collaboration.reload.rejected?).to be false }
      it { is_expected.to redirect_to root_path }
    end
  end
end
