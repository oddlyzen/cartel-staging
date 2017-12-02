class Education < ActiveRecord::Base
  belongs_to :user, touch: true

  validates :start_year, :start_month, :education_level, :field_of_study, :institution, presence: true
  validates :end_month, :end_year, presence: true, if: -> { current == false }

  validates :other_institution, presence: true, if: Proc.new { |e| e.institution == "Other" }

  def current?
    !!current
  end
end
