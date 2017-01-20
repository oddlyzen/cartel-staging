class Institution < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true

end
