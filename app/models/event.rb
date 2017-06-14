class Event < ActiveRecord::Base
  belongs_to :company
  has_many :opening_times
end
