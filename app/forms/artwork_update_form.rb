class ArtworkUpdateForm < BaseForm

  validate :artwork_is_valid?

  attr_accessor :artwork

  def initialize(params = {})
    @owner = User.find(params[:user_id])
    @artwork = @owner.artworks.find(params.delete(:id))
    @collaborator_ids = params.delete(:collaborator_ids)&.map(&:to_i)
    @artwork_params = params
  end

  def save
    assign_artwork_attributes if @artwork

    if valid?
      ActiveRecord::Base.transaction do
        @artwork.save!
        save_new_collaborators unless @collaborator_ids.nil?
        destroy_removed_collaborators!
      end
    end
    errors.empty?
  rescue ActiveRecord::RecordInvalid => e
    e.record.errors.full_messages.each { |message| errors.add(:base, message) }
    false
  end

  private

  def assign_artwork_attributes
    @artwork.assign_attributes(@artwork_params)
  end

  def save_new_collaborators
    @collaborator_ids.each do |id|
      collaboration = @artwork.artwork_collaborators.find_or_initialize_by(user_id: id)
      collaboration.save! if collaboration.new_record?
    end
  end

  def destroy_removed_collaborators!
    @artwork.artwork_collaborators.where.not(user_id: @collaborator_ids).destroy_all
  end

  def artwork_is_valid?
    if @artwork.series.published? && !@artwork.valid?(:series_save)
      errors.add(:artwork, 'Please check your forms again')
      @artwork.errors.each do |artwork_attribute, error|
        errors.add('Check the following: ' + artwork_attribute.to_s, error)
      end
    elsif !@artwork.valid?
      errors.add(:artwork, 'Please check your forms again')
      @artwork.errors.each do |artwork_attribute, error|
        errors.add('Check the following: ' + artwork_attribute.to_s, error)
      end
    end
  end

end
