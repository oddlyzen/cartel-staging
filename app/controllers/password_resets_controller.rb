class PasswordResetsController < ApplicationController
  skip_before_action :require_login

  def create
    @user = User.find_by(email: params[:email])
    @user&.deliver_reset_password_instructions!

    redirect_to root_path, notice: 'Please check your email with instructions on how to reset your password'
  end

  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])

    if @user.blank?
      flash[:alert] = 'User does not exist'
      not_authenticated
    end
  end

  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])

    if @user.blank?
      flash[:alert] = 'Sorry but this account is invalid'
      not_authenticated
      return
    end

    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.change_password!(params[:user][:password])
      redirect_to root_path, notice: 'Your password has successfully been updated'
    else
      flash[:alert] = 'User does not exist'
      render :edit
    end
  end
end
