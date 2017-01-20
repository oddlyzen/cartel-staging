require 'rails_helper'

RSpec.describe RegistrationForm, type: :form do

  let!(:media) { create(:medium) }
  let!(:subjects) { create(:subject) }
  let!(:specialisation) { create(:specialisation) }
  let(:company_name) { ['ABC Inc.'] }
  let(:referrer) { create(:user, :artist) }
  let(:company) { create(:company) }

  let(:user_artist_params) do
    attributes_for(:user, :artist, artist_status_text: company_name, referrer_id: referrer.id)
  end

  let(:user_professional_params) do
    attributes_for(
      :user,
      :professional,
      professional_status_text: company_name,
      experiences_attributes: { '0' => attributes_for(:experience) }
    )
  end
  let(:other_media_array_params) { %w(Activism Media1 Media2) }
  let(:other_subjects_array_params) { %w(Nude Subjects1 Subjects2) }
  let(:other_specialisations_array_params) { %w(Idea Specialisation1 Specialisation2) }

  describe '#save' do

    context 'user authenticates using oauth' do
      let(:oauth_params) do
        { 'provider' => 'facebook', 'uid' => 'abc123' }
      end

      subject(:registration_form) do
        described_class.new({ user_attributes: user_artist_params }, oauth_params)
      end

      before { subject.save }

      it { expect(subject.user).to be_persisted }
      it { expect(subject.user.authentications.count).to eq(1) }

    end

    context 'artist with valid params' do

      subject(:registration_form) do
        described_class.new(user_attributes: user_artist_params)
      end

      before { subject.save }

      it { expect(subject.user).to be_persisted }
      it { expect(subject.user.referrer).to be_present }
      it { expect(subject.user.pending_passive_friends.count).to eq(1) }
      it { expect(subject.user.authentications).to be_empty }

    end

    context 'artist with valid params and new companies, media and subjects' do

      subject(:registration_form) do
        described_class.new(
          user_attributes: user_artist_params,
          other_media_array: other_media_array_params,
          other_subjects_array: other_subjects_array_params
        )
      end

      before { subject.save }

      it { expect(subject.user.media_tags).not_to include('') }
      it { expect(subject.user.subjects_tags).not_to include('') }
      it { expect(subject.user.specialisations_tags).to eq([]) }
      it { expect(Company.find_by(name: company_name)).to be }
      it { expect(Medium.count).to eq(4) }
      it { expect(Subject.count).to eq(4) }
      it { expect(CompanyMembership.find_by(user_id: subject.user, company_id: Company.find_by(name: company_name))) }
      it { expect(subject.user.authentications).to be_empty }
    end

    context 'professional with valid params' do

      subject(:registration_form) do
        described_class.new(
          user_attributes: user_artist_params,
          other_media_array: other_media_array_params,
          other_subjects_array: other_subjects_array_params
        )
      end

      before { subject.save }

      it { expect(subject.user).to be_persisted }
      it { expect(subject.user.authentications).to be_empty }

    end

    context 'professional with more than one current work experience' do

      let!(:user_professional_params) do
        attributes_for(
          :user,
          :professional,
          professional_status_text: company.name,
          experiences_attributes: { '0' => attributes_for(:experience, :current).merge(company_name: company.name),
                                    '1' => attributes_for(:experience, :current).merge(company_name: company.name) }
        )
      end
      subject(:registration_form) do
        described_class.new(user_attributes: user_professional_params)
      end

      it { expect(subject.valid?).to be_falsey }
      it { expect { subject.save }.to change { User.count }.by(0) }

    end

    context 'professional with empty work experiences' do

      let!(:user_professional_params) do
        attributes_for(
          :user,
          :professional,
          professional_status_text: company.name,
          experiences_attributes: { '0' => attributes_for(:experience, :invalid).merge(company_name: company.name) }
        )
      end
      subject(:registration_form) do
        described_class.new(user_attributes: user_professional_params)
      end

      it { expect(subject.valid?).to be_falsey }
      it { expect { subject.save }.to change { User.count }.by(0) }

    end

    context 'professional with valid params and new companies and specialisations' do

      context 'no corresponding work experience' do
        subject(:registration_form) do
          described_class.new(
            user_attributes: user_professional_params,
            other_specialisations_array: other_specialisations_array_params
          )
        end

        before { subject.save }

        it { expect(subject.user.media_tags).to eq([]) }
        it { expect(subject.user.subjects_tags).to eq([]) }
        it { expect(subject.user.specialisations_tags).not_to include('') }
        it { expect(Company.find_by(name: company_name)).to be_nil }
        it { expect(Specialisation.count).to eq(1) }
        it { expect(CompanyMembership.find_by(user_id: subject.user, company_id: Company.find_by(name: company_name))) }
      end

      context 'with corresponding work experience' do
        let!(:user_professional_params) do
          attributes_for(
            :user,
            :professional,
            professional_status_text: company.name,
            experiences_attributes: { '0' => attributes_for(:experience, :current).merge(company_name: company.name) }
          )
        end
        subject(:registration_form) do
          described_class.new(
            user_attributes: user_professional_params,
            other_specialisations_array: other_specialisations_array_params
          )
        end

        before { subject.save }

        it { expect(subject.user.media_tags).to eq([]) }
        it { expect(subject.user.subjects_tags).to eq([]) }
        it { expect(subject.user.specialisations_tags).not_to include('') }
        it { expect(Company.find_by(name: company.name)).to be }
        it { expect(Specialisation.count).to eq(4) }
        it { expect(CompanyMembership.find_by(user_id: subject.user, company_id: Company.find_by(name: company_name))) }
      end

    end
  end

  context 'with invalid params' do

    subject(:registration_form) do
      described_class.new(user_attributes: attributes_for(:user, :invalid))
    end

    before { subject.save }

    it { expect(subject.errors).not_to be_nil }

    context 'because of empty password' do
      subject(:registration_form) do
        described_class.new(user_attributes: attributes_for(:user, password: '', password_confirmation: ''))
      end

      it { expect(subject.user).not_to be_persisted }
      it { expect(subject.errors).not_to be_nil }
    end
  end

end
