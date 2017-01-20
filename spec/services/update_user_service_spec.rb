require 'rails_helper'

RSpec.describe UpdateUserService, type: :service do

  let(:user) do
    create(
      :user,
      :artist,
      first_name: 'My First Name'
    ).reload
  end

  let(:form_params) do
    { user_attributes: user_attributes }
  end

  subject { described_class.new(user, form_params) }

  describe '#call' do
    context 'with valid params' do
      context 'and changes to user' do
        let(:user_attributes) { attributes_for(:user, first_name: 'New First Name') }
        it { expect(subject.call).to be_success }
        it { expect(subject.call.data.user.changed).to be_empty }
        it { expect(subject.call.data.feed_item).to be_persisted }
      end

      context 'and no changes to user' do
        let(:user_attributes) do
          attributes_for(
            :user,
            first_name: user.first_name,
            email: user.email
          ).except(:password, :password_confirmation)
        end

        it { expect(subject.call).to be_success }
        it { expect(subject.call.data.feed_item).not_to be_present }
      end
    end

    context 'with invalid params' do
      let(:user_attributes) { attributes_for(:user, :invalid) }
      it { expect(subject.call).not_to be_success }
      it { expect(subject.call.data.user.changes).not_to be_empty }
      it { expect(subject.call.data.feed_item).not_to be_present }
    end
  end

end
