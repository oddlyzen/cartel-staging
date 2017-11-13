module My
  class ProfilesController < My::BaseController

    def edit
      @user = ProfilePresenter.new(@user.id).user
      @profile_form = My::ProfileForm.new(@user)
    end

    def update
      update_service_call = UpdateUserService.new(@user, user_params).call

      if update_service_call.success?
        redirect_to @user.artist? ? artist_path(@user) : professional_path(@user), notice: 'Your profile has been updated'
      else
        flash[:error] = " Please review your form and make sure all fields marked as red are not empty"
        redirect_to edit_my_profile_path(errors: @user.errors.messages)
      end
    end

    private

    def user_params
      params.require(:my_profile_form).permit(
        user_attributes: [
          :tagline, :profile_image_url, :statement, :link, :interest, :skills, :language, :language_level, :current_status, :commission, :facebook_link, :twitter_link, :instagram_link, :institution, :education_level, :education_grade, :exhibit_country, :based_state, :based_country, :based_location, :nationality_country, :field_of_study, :residency_status, :other_status,
          artist_status_text: [],
          professional_status_text: [],
          representative_ids: [],
          educations_attributes: [:location, :start_month, :start_year, :end_month, :end_year, :institution, :other_institution, :education_level, :education_grade, :field_of_study, :education_description, :state, :country, :id, :_destroy],
          awards_attributes: [:location, :title, :month, :year, :country, :state, :awarding_body, :prize, :pdf_url, :id, :_destroy],
          residencies_attributes: [:location, :start_month, :start_year, :end_month, :end_year, :current, :body, :title, :country, :state, :id, :_destroy],
          experiences_attributes: [:location, :start_month, :start_year, :end_month, :end_year, :current, :position, :company_id, :state, :country, :category, :job_type, :description, :link, :id, :company_name, :_destroy],
          exhibitions_attributes: [:pdf_filename, :location, :involvement_string, :record_start_year, :record_end_year, :start_month, :end_month, :start_year, :end_year, :title, :category, :venue_id, :state, :country, :pdf_url, :id, :_destroy],
          bibliographies_attributes: [:pdf_filename, :volume, :review_of, :location, :title, :publication_title, :publisher, :edition, :author, :page_number, :source_type, :link, :participation, :publication_city, :publication_country, :editor, :issue, :pdf_url, :attachment_url, :day, :month, :year, :id, :_destroy],
          publications_attributes: [:pdf_filename, :location, :volume, :review_of, :participation, :category, :title, :publication_title, :country, :state, :day, :month, :year, :publisher, :edition, :editor, :issue, :page_numbers, :link, :pdf_url, :attachment_url, :id, :_destroy],
          participations_attributes: [:month, :year, :title, :description, :link, :id, :_destroy],
          collections_attributes: [:name, :id, :_destroy],
          memberships_attributes: [:name, :start_date, :end_date, :id, :_destroy],
          media_features_attributes: [:month, :year, :title, :description, :link, :id, :_destroy],
          profile_attributes: [
            :id,
            medium_ids: [],
            subject_ids: [],
            interest_ids: [],
            skill_ids: [],
            specialisation_ids: [],
            service_ids: [],
            language_proficiencies_attributes: [:id, :language_id, :level, :_destroy]
          ]
        ]
      )
    end
  end

end
