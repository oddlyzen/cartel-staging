class InterestForm < BaseForm

  attr_accessor :name, :title, :email, :interest, :message, :attachment

  validates :name, :title, :email, :interest, presence: true
  validates :attachment, presence: true, if: :interest_artist_or_professional
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  def initialize(params = {})
    @name = params[:name]
    @title = params[:title]
    @email = params[:email]
    @interest = params[:interest]
    @attachment = params[:attachment]
    @message = params[:message]
  end

  private
    def interest_artist_or_professional
      ["Artist", "Art Professional"].include?(@interest)
    end
end
