require 'rails_helper'

RSpec.describe UserDecorator, type: :decorator do

  let(:user) { build(:user, educations: [build(:education)]) }
  let(:user_empty) { build(:user, :empty) }

  let(:decorator) { UserDecorator.new(user) }
  let(:decorator_empty) { UserDecorator.new(user_empty) }

  let!(:media) { create_list(:medium, 2) }
  let!(:subjects) { create_list(:subject, 2) }
  let!(:interests) { create_list(:interest, 2) }
  let!(:skills) { create_list(:skill, 2) }
  let!(:specialisations) { create_list(:specialisation, 2) }
  let!(:services) { create_list(:service, 2) }
  let!(:language_proficiencies) { build_list(:language_proficiency, 2, language: build(:language)) }

  let!(:profile) do
    create(:profile, user: user,
                     medium_ids: [media.first.id, media.last.id],
                     subject_ids: [subjects.first.id, subjects.last.id],
                     interest_ids: [interests.first.id, interests.last.id],
                     skill_ids: [skills.first.id, skills.last.id],
                     specialisation_ids: [specialisations.first.id, specialisations.last.id],
                     service_ids: [services.first.id, services.last.id],
                     language_proficiencies: language_proficiencies)
  end

  let!(:profile_empty) { build(:profile, :empty, user: user_empty) }

  it { expect(decorator.full_name).to eq("#{user.first_name} #{user.last_name}") }

  it { expect(decorator.available_for_commission).to eq('Yes') }

  it { expect(decorator.display_based_in).to eq("#{user.based_state.humanize}, #{user.based_country}") }

  it { expect(decorator.display_role).to eq((user.role&.humanize).to_s) }

  it { expect(decorator.link_to_website).to eq("http://#{user.link}") }
  it { expect(decorator_empty.link_to_website).to eq('No Website Available') }

  it { expect(decorator.tag_list(:media)).to eq(profile.media.join(', ')) }
  it { expect(decorator_empty.tag_list(:media)).to eq('No Media Selected') }

  it { expect(decorator.tag_list(:subjects)).to eq(profile.subjects.join(', ')) }
  it { expect(decorator_empty.tag_list(:subjects)).to eq('No Subjects Selected') }

  it { expect(decorator.tag_list(:skills)).to eq(profile.skills.join(', ')) }
  it { expect(decorator_empty.tag_list(:skills)).to eq('No Skills Selected') }

  it { expect(decorator.tag_list(:languages)).to eq(profile.languages.join(', ')) }
  it { expect(decorator_empty.tag_list(:languages)).to eq('No Languages Selected') }

  it { expect(decorator.tag_list(:interests)).to eq(profile.interests.join(', ')) }
  it { expect(decorator_empty.tag_list(:interests)).to eq('No Interests Selected') }

  it { expect(decorator.tag_list(:specialisations)).to eq(profile.specialisations.join(', ')) }
  it { expect(decorator_empty.tag_list(:specialisations)).to eq('No Specialisations Selected') }

  it { expect(decorator.tag_list(:services)).to eq(profile.services.join(', ')) }
  it { expect(decorator_empty.tag_list(:services)).to eq('No Services Selected') }

  it { expect(decorator.educations).to eq(user.educations) }
  it { expect(decorator_empty.educations).to be_blank }

  describe '#pdf_exhibitions' do
    context 'with attachments' do
      let!(:attachment) { user.exhibitions.create(attributes_for(:exhibition, :with_attachment)) }

      it { expect(decorator.pdf_exhibitions).to eq(user.exhibitions.with_attachment) }
    end

    context 'without attachments' do
      it { expect(decorator_empty.pdf_exhibitions).to be_blank }
    end
  end

end
