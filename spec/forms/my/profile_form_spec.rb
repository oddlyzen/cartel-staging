require 'rails_helper'

RSpec.describe My::ProfileForm, type: :form do

  let(:artist) { create(:user, :artist) }

  let(:company_a) { create(:company) }
  let(:company_b) { create(:company) }

  let(:form_params) do
    {
      user_attributes: user_params
    }
  end

  let(:user_params) { attributes_for(:user) }

  subject do
    described_class.new(artist, form_params)
  end

  describe '#save' do

    context 'with valid params' do
      it { expect(subject.save).to be_truthy }

      context 'with no representative' do
        it { expect { subject.save }.not_to change(subject.user.company_memberships, :count) }
      end

      context 'with a removed representative' do
        let!(:membership) { create(:company_membership, user: artist, company: company_a) }

        it { expect { subject.save; artist.reload; }.to change(artist.company_memberships, :count).by(-1) }
      end

      context 'with a new representative' do
        let(:user_params) { attributes_for(:user).merge(representative_ids: [company_b.id]) }

        it { expect { subject.save; artist.reload; }.to change(artist.company_memberships, :count).by(1) }
      end
    end

    context 'with invalid params' do
      let(:user_params) { attributes_for(:user, :invalid) }

      it { expect(subject.save).to be_falsey }

      context 'with no representative' do
        it { expect { subject.save }.not_to change(subject.user.company_memberships, :count) }
      end

      context 'with a removed representative' do
        let!(:membership) { create(:company_membership, user: artist, company: company_a) }

        it { expect { subject.save; artist.reload; }.not_to change(artist.company_memberships, :count) }
      end

      context 'with a new representative' do
        let(:user_params) { attributes_for(:user, :invalid).merge(representative_ids: [company_b.id]) }

        it { expect { subject.save; artist.reload; }.not_to change(artist.company_memberships, :count) }
      end
    end

    context 'with more than one current work experience for professional' do

      let(:form_params) do
        {
          user_attributes: professional.attributes.merge(
            experiences_attributes: { '0' => attributes_for(:experience, :current).merge(company: company_a),
                                      '1' => attributes_for(:experience, :current).merge(company: company_b) }
          )
        }
      end

      let(:professional) { create(:user, :professional) }
      subject { described_class.new(professional, form_params) }

      it { expect(subject.valid?).to be_falsey }

    end

    context 'work_experience_is_valid?' do

      context 'mismatch between current membership and work experience' do
        let!(:membership) { create(:company_membership, user: professional, company: company_a) }

        let(:form_params) do
          {
            user_attributes: professional.attributes.merge(
              representative_ids: [company_a.id],
              experiences_attributes: { '0' => attributes_for(:experience, :current).merge(company: company_a),
                                        '1' => attributes_for(:experience, :current).merge(company: company_b) }
            )
          }
        end

        let(:professional) { create(:user, :professional) }
        subject { described_class.new(professional, form_params) }

        it { expect(subject.valid?).to be_falsey }
      end

      context 'valid case' do
        let!(:membership) { create(:company_membership, user: professional, company: company_a) }

        let(:form_params) do
          {
            user_attributes: professional.attributes.merge(
              representative_ids: [company_a.id],
              experiences_attributes: { '0' => attributes_for(:experience, :current).merge(company: company_a),
                                        '1' => attributes_for(:experience).merge(company: company_b) }
            )
          }
        end

        let(:professional) { create(:user, :professional) }
        subject { described_class.new(professional, form_params) }

        it { expect(subject.valid?).to be_truthy }
      end
    end

  end

end
