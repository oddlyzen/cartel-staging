class Profile < ActiveRecord::Base

  belongs_to :user, touch: true

  has_many :language_proficiencies
  has_many :languages, through: :language_proficiencies

  accepts_nested_attributes_for :language_proficiencies, reject_if: :all_blank, allow_destroy: true

  def media
    Medium.approved.where(id: medium_ids).pluck(:name)
  end

  def subjects
    Subject.approved.where(id: subject_ids).pluck(:name)
  end

  def interests
    Interest.approved.where(id: interest_ids).pluck(:name)
  end

  def skills
    Skill.approved.where(id: skill_ids).pluck(:name)
  end

  def specialisations
    Specialisation.approved.where(id: specialisation_ids).pluck(:name)
  end

  def services
    Service.approved.where(id: service_ids).pluck(:name)
  end

end
