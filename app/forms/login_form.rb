class LoginForm < BaseForm

  attr_accessor :email, :password
  attr_reader :user

  validates :email, :password, presence: true
  validate :user_must_exist
  validate :user_must_be_active

  def initialize(params = {})
    super(params)
    @user = User.find_by(email: @email)
  end

  def valid?
    return false unless super
    errors.add(:password, 'is invalid') unless @user.try(:valid_password?, @password)
    errors.empty?
  end

  private

  def user_must_exist
    errors.add(:user, 'does not exist') if @user.blank?
  end

  def user_must_be_active
    errors.add(:user, 'is inactive') if @user && !@user.active?
  end

end
