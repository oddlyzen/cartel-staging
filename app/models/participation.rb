class Participation < ActiveRecord::Base

  belongs_to :user, touch: true

end
