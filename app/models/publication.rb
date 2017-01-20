class Publication < ActiveRecord::Base

  belongs_to :user, touch: true

  enum participation: %w(editor writer)
  enum category: %w(book catalogue article essay review paper)

end
