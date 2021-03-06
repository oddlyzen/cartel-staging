class SubEvent < ActiveRecord::Base
  belongs_to :event

  validates :description, :start_date, :start_time, :end_time, presence: true, if: Proc.new { |sb| sb.name.present? }

  after_save :delete_if_name_empty, if: Proc.new { |sb| sb.name.in?([nil, ""]) }

  def delete_if_name_empty
    self.destroy
  end
end
