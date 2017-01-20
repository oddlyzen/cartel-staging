class EnquiryForm < BaseForm

  attr_accessor :name, :email, :subject, :message

  validates :name, :email, :subject, :message, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  def initialize(params = {})
    @name = params[:name]
    @email = params[:email]
    @subject = params[:subject]
    @message = params[:message]
  end

end
