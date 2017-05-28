class Membership < ActiveRecord::Base

  belongs_to :user, touch: true

  belongs_to :company

  validates :name, presence: true

end
