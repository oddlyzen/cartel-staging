class SessionsController < ApplicationController

  layout 'landing'

  before_action :require_login, only: [:destroy]
  before_action :redirect_if_user_logged_in, only: [:new]

  def new
    @form = LoginForm.new
  end

  def create
    @form = LoginForm.new(login_params)
    if @form.valid?
      login(@form.email, @form.password)
      redirect_to logged_in_path
    else
      flash.now[:error] = 'Please try again'
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: 'You have been logged out'
  end

  private

  def login_params
    params.require(:login_form).permit(:email, :password)
  end

  def redirect_if_user_logged_in
    redirect_to my_feed_path if current_user
  end

  def logged_in_path
    current_user.admin? ? admin_users_path : my_feed_path
  end

end
