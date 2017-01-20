require 'rails_helper'

RSpec.describe My::MembershipsController, type: :controller do

  let(:company_owner) { create(:user) }
  let(:company) { create(:company, owner: company_owner) }

  before do
    login_user company_owner
  end

  describe '#POST create' do
    let(:non_member) { create(:user, :artist) }
    let(:user_id) { non_member.id }

    before { post :create, company_id: company.id, user_id: user_id }

    context 'with valid params' do
      it { expect(non_member.reload.company_memberships.count).to eq(1) }
      it { is_expected.to redirect_to(my_company_path(company)) }
    end

    context 'with invalid params' do
      let(:user_id) { nil }

      it { expect(non_member.reload.company_memberships).to be_empty }
      it { is_expected.to redirect_to(my_company_path(company)) }
    end
  end

  describe '#DELETE destroy' do
    let(:member) { create(:user, :artist) }
    let(:membership_company) { company }
    let(:membership) { create(:company_membership, state: :approved, company: membership_company, user: member) }

    before { delete :destroy, company_id: company.id, member_id: member.id }

    context 'with valid params' do
      it { expect(member.reload.company_memberships).to be_empty }
      it { is_expected.to redirect_to(my_company_path(company)) }
    end

    context 'with invalid params' do
      let(:membership_company) { create(:company) }

      it { is_expected.to redirect_to(my_company_path(company)) }
      it { expect(flash[:alert]).to eq 'Something went wrong. Please try again!' }
    end
  end

  describe '#PATCH approve' do
    let(:membership) { create(:company_membership, company: company, state: :pending) }

    before { patch :approve, company_id: company.id, id: membership.id }

    context 'with valid params' do
      it { expect(membership.reload.approved?).to be true }
      it { is_expected.to redirect_to(:back) }
      it { expect(flash[:notice]).to eq 'User approved!' }
    end

    context 'with invalid params' do
      let(:membership) { create(:company_membership, company: company, state: :rejected) }

      it { expect(membership.reload.approved?).to be false }
      it { is_expected.to redirect_to(:back) }
      it { expect(flash[:alert]).to eq 'Something went wrong. Please try again!' }
    end
  end

  describe '#PATCH reject' do
    let!(:membership) { create(:company_membership, company: company, state: :pending) }

    before { patch :reject, company_id: company.id, id: membership.id }

    context 'with valid params' do

      it { expect(membership.reload.rejected?).to be true }
      it { is_expected.to redirect_to(:back) }
      it { expect(flash[:notice]).to eq 'User rejected!' }
    end

    context 'with invalid params' do
      let!(:membership) { create(:company_membership, company: company, state: :approved) }

      it { expect(membership.reload.rejected?).to be false }
      it { is_expected.to redirect_to(:back) }
      it { expect(flash[:alert]).to eq 'Something went wrong. Please try again!' }
    end
  end

end
