class Membership < ActiveRecord::Base

  belongs_to :user, touch: true

  belongs_to :company

end
