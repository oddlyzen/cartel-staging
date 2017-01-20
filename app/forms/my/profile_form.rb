class My::ProfileForm
  include ActiveModel::Model
  include ActiveModel::Validations

  attr_reader :user

  delegate :professional?, to: :user, prefix: false

  delegate :attributes=, to: :user, prefix: true
  validate :user_is_valid?
  validate :atmost_one_current_work_experience?, if: :professional?

  def initialize(user, params = {})
    @user = user
    @params = params.dup
    assign_company_ids if @params[:user_attributes]
    super(@params)
  end

  def save
    if valid?
      ActiveRecord::Base.transaction do
        destroy_removed_memberships
        save_new_memberships
        @user.save
      end
    end
    errors.empty?
  end

  private

  def atmost_one_current_work_experience?
    if @user.experiences.to_a.count(&:current) > 1
      errors.add(:base, 'Work Experience: Cannot have more than one current work experience')
    end
  end

  def user_is_valid?
    unless @user.valid?
      @user.errors.each do |user_attribute, error|
        errors.add('user: ' + user_attribute.to_s, error)
      end
    end
  end

  def assign_company_ids
    @company_ids = @params[:user_attributes].delete(:representative_ids)&.map(&:to_i).to_a
    return @company_ids unless @params[:user_attributes][:experiences_attributes].present?
    @company_ids += experiences_ids
  end

  def experiences_ids
    @params[:user_attributes][:experiences_attributes].values.map { |e| e[:company_id].to_i }
  end

  def save_new_memberships
    return if @company_ids.blank?
    @company_ids.each do |company_id|
      membership = @user.company_memberships.find_or_initialize_by(company_id: company_id)
      membership.save! if membership.new_record?
    end
  end

  def destroy_removed_memberships
    if @company_ids.blank?
      @user.company_memberships.destroy_all
    else
      @user.company_memberships.where.not(company_id: @company_ids).destroy_all
    end
  end

end
