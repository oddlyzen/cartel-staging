class Education < ActiveRecord::Base
  belongs_to :user, touch: true

  validates :start_year, :start_month, :end_year, :end_month, :education_level, :education_grade, :field_of_study, :institution, presence: true
  validates :other_institution, presence: true, if: Proc.new { |e| e.institution == "Other" }
end
