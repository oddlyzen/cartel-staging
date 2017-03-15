class ContactsController < ApplicationController

  def interest
    @form = InterestForm.new(interest_params)
    if @form.valid?
      ContactMailer.interest(interest_params).deliver_later
      redirect_to root_path, notice: 'Thank you for your interest. We will get back to you shortly'
    else
      flash[:error] = @form.errors.full_messages
      redirect_to about_path
    end
  end

  def enquiry
    @form = EnquiryForm.new(enquiry_params)
    if @form.valid?
      ContactMailer.enquiry(enquiry_params).deliver_later
      redirect_to root_path, notice: 'Thank you for your enquiry. We will get back to you shortly'
    else
      flash[:error] = @form.errors.full_messages
      redirect_to contact_us_path
    end
  end

  private

  def interest_params
    params.require(:interest_form).permit(:title, :name, :email, :interest)
  end

  def enquiry_params
    params.require(:enquiry_form).permit(:name, :vocation, :email, :subject, :message)
  end
end
