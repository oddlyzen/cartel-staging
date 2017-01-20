require 'rails_helper'

RSpec.describe My::CompanyPresenter, type: :presenter do
  let(:owner) { create(:user, :artist) }
  let(:company) { create(:company, owner: owner) }
  let(:member) { create(:user, :artist) }
  let(:non_member) { create(:user, :artist) }
  let!(:membership) { create(:company_membership, company: company, user: member) }

  subject(:company_presenter) do
    described_class.new(
      user_id: owner.id,
      company_id: company.id
    )
  end

  describe '#memberships' do
    it 'returns a membership collection' do
      expect(company_presenter.memberships).to include(membership)
    end
  end

  describe '#members' do
    it 'returns a members collection' do
      expect(company_presenter.members).to include(member)
    end
  end

  describe '#non_members' do
    it 'returns a non-members collection' do
      expect(company_presenter.non_members).to include(non_member)
    end
  end
end
