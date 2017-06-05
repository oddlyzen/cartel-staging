class RegistrationsController < ApplicationController

  JS_ASSETS = %w(application registrations).freeze

  layout 'landing'

  def new
    @registration_form = RegistrationForm.new(user_attributes: oauth_user_params)
  end

  def create
    @registration_form = RegistrationForm.new(user_params, oauth_params)
    if @registration_form.save
      session.delete('oauth_info')
      auto_login(@registration_form.user)
    else
      flash.now[:error] = 'Please check your form again and re-submit'
    end
  end

  private

  def user_params
    params.require(:registration_form).permit(
      :other_current_status_string,
      user_attributes: [
        :email, :password, :password_confirmation, :first_name, :last_name, :exhibitions,
        :role, :title, :date_of_birth, :nationality_country, :residency_status, :gender,
        :based_country, :based_state, :based_location, :current_status, :commission, :professional_status_text,
        :exhibit_title, :participation, :venue, :exhibit_country, :exhibit_state, :referrer_id,
        :link, :from_record_year, :to_record_year, :acknowledgement, :from_exhibit_date,
        :to_exhibit_date, :representation, :position, :company_name, :gallery_museum,
        media_tags: [], subjects_tags: [], specialisations_tags: [], artist_status_text: [],
        exhibitions_attributes: [
          :record_start_year, :record_end_year, :start_month, :end_month, :title, :venue_name, :state, :country, :category,
          :start_year, :end_year, :involvement, :representation, :link, :pdf_url, :location, :pdf_filename
        ],
        experiences_attributes: [
          :start_month, :start_year, :end_month, :end_year, :current, :position, :job_type,
          :company_name, :state, :country, :description, :link, :category, :location
        ]
      ],
      profile_attributes: [
        medium_ids: [],
        subject_ids: [],
        specialisation_ids: []
      ],
      other_media_array: [],
      other_subjects_array: [],
      other_specialisations_array: []
    )
  end

  def oauth_user_params
    params.permit(:first_name, :last_name, :email)
  end

  def oauth_params
    session['oauth_info']
  end

end
