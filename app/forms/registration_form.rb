class RegistrationForm < BaseForm

  attr_reader :user, :profile
  attr_accessor :other_media_array, :other_subjects_array, :other_specialisations_array, :other_current_status_string

  delegate :attributes=, to: :exhibition, prefix: true
  delegate :attributes=, to: :experience, prefix: true
  delegate :attributes=, to: :profile, prefix: true

  delegate :professional?, to: :user, prefix: false

  validate :user_is_valid?
  # validate :atmost_one_current_work_experience?, if: :professional?
  # validate :work_experience_matches_with_current_status?, if: :professional?
  # validate :work_experiences_are_valid?, if: :professional?

  def initialize(params = {}, oauth_params = {})
    @user = User.find_by(id: params.delete(:id)) || User.new
    @profile = @user.build_profile
    @oauth_params = oauth_params

    @other_current_status_string = params[:other_current_status_string]

    if params[:user_attributes].blank?
      @user.experiences.build
      @user.exhibitions.build
    end

    super(params)
    initialize_tags(Medium, @other_media_array)
    initialize_tags(Subject, @other_subjects_array)
    initialize_tags(Specialisation, @other_specialisations_array)
  end

  def user_attributes=(user_params)
    user_params = user_params.dup
    user_params[:professional_status_text] = Array(user_params[:professional_status_text])
    [:artist_status_text, :professional_status_text].each do |name|
      user_params[name] = cleanup_array(user_params[name])
    end

    exhibitions_attributes = user_params.delete(:exhibitions_attributes)
    @experiences_attributes = user_params.delete(:experiences_attributes)

    @user.assign_attributes(user_params)
    assign_exhibitions(exhibitions_attributes)
    assign_experiences(@experiences_attributes)
    initialize_blank_password_if_nil
    set_nil_password_for_oauth_users

    if ['Others', 'Other status'].include? @user.current_status
      initialize_other_status_text
    else
      initialize_companies
    end
  end

  def save
    @profile.role = @user.role

    return false unless valid?
    ActiveRecord::Base.transaction do
      save_tags(@other_medium)
      save_tags(@other_subject)
      save_tags(@other_specialisation)
      @user.save!
      create_authentication
      @profile.save!
      save_companies
      save_connection
    end
    true
  rescue ActiveRecord::RecordInvalid => e
    e.record.errors.full_messages.each { |message| errors.add(:base, message) }
    false
  end

  private

  def work_experiences_are_valid?
    experience_errors = []
    @user.experiences.each do |exp|
      unless all_blank?(exp)
        experience_errors << exp.errors.full_messages unless exp.valid?(:update)
      end
    end
    errors.add(:base, "Work Experience: #{experience_errors.flatten.uniq.join(', ')}") unless experience_errors.flatten.blank?
  end

  def atmost_one_current_work_experience?
    if @user.experiences.to_a.count(&:current) > 1
      errors.add(:base, 'Work Experience: Cannot have more than one current work experience')
    end
  end

  def work_experience_matches_with_current_status?
    current_work_experience = @experiences_attributes.values.detect { |exp| exp[:current] == '1' } || {}
    companies_matched = @companies&.collect(&:name)&.include?(current_work_experience[:company_name])
    if @user.current_status == 'Works at' && !companies_matched
      errors.add(:base, 'Work Experience: Current Status does not have a corresponding current work experience')
    end
  end

  def assign_exhibitions(exhibitions)
    return if exhibitions.blank?
    exhibitions.values.each do |exhibition_attributes|
      venue = Company.find_or_initialize_by(name: exhibition_attributes[:venue_name])
      @user.exhibitions.build(exhibition_attributes.merge(venue: venue))
    end
  end

  def assign_experiences(experiences)
    return if experiences.blank?
    experiences.values.each do |experience_attributes|
      company = Company.find_or_initialize_by(name: experience_attributes[:company_name])
      @user.experiences.build(experience_attributes.merge(company_id: company.id))
    end
  end

  def cleanup_array(array)
    array.reject(&:blank?).uniq if array
  end

  def all_blank?(record)
    record.attributes.values.reject(&:blank?).blank?
  end

  def initialize_other_status_text
    status_text = @other_current_status_string.present? ? [@other_current_status_string] : []
    @user.artist_status_text = status_text if @user.role == 'artist'
    @user.professional_status_text = status_text if @user.role == 'professional'
  end

  def initialize_companies
    status_text = @user.role == 'artist' ? @user.artist_status_text : @user.professional_status_text
    return if status_text.blank?
    @companies = status_text.map do |company_name|
      Company.find_or_initialize_by(name: company_name)
    end
  end

  def initialize_tags(klass, tags)
    return if tags.blank?
    tag_class = klass.model_name.singular
    tags = cleanup_array(tags).map do |tag_name|
      klass.find_or_initialize_by(name: tag_name).tap do |tag|
        if tag.new_record?
          tag.user = @user
        elsif tag.persisted?
          @profile.send("#{tag_class}_ids") << tag.id if tag.persisted?
        end
      end
    end
    instance_variable_set("@other_#{tag_class}", tags)
  end

  def save_companies
    return if @companies.blank?
    @companies.each do |company|
      company.save!
      company.company_memberships.create(user: @user)
    end
  end

  def save_tags(tags)
    return if tags.blank?
    tags.each do |tag|
      @profile.send("#{tag.class.model_name.singular}_ids") << tag.id if tag.save!
    end
  end

  def user_is_valid?
    unless @user.valid?
      @user.errors.each do |user_attribute, error|
        errors.add('user: ' + user_attribute.to_s, error)
      end
    end
  end

  def save_connection
    return unless @user.referrer
    @referrer = User.find(@user.referrer_id)
    @referrer.connections.create(friend: @user)
  end

  def initialize_blank_password_if_nil
    return unless oauth_present?
    @user.password ||= ''
    @user.password_confirmation ||= ''
  end

  def set_nil_password_for_oauth_users
    if oauth_present? && @user.password.blank? && @user.password_confirmation.blank?
      @user.password = nil
      @user.password_confirmation = nil
    end
  end

  def create_authentication
    if oauth_present?
      @user.add_provider_to_user(@oauth_params['provider'], @oauth_params['uid'])
    end
  end

  def oauth_present?
    if @oauth_params.blank?
      false
    else
      !@oauth_params['provider'].blank? && !@oauth_params['uid'].blank?
    end
  end

end
