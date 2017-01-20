class InterestForm < BaseForm

  attr_accessor :name, :title, :email, :interest

  validates :name, :title, :email, :interest, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  def initialize(params = {})
    @name = params[:name]
    @title = params[:title]
    @email = params[:email]
    @interest = params[:interest]
  end

end
