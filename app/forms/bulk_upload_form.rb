class BulkUploadForm < BaseForm

  attr_accessor :image_urls

  def initialize(params = {})
    @user_id = params[:user_id]
    @urls = params[:image_urls]
  end

  def save
    unless @urls.nil? || @urls.blank?
      prepare_artworks
      save_artworks
    end
  rescue ActiveRecord::RecordInvalid => e
    e.record.errors.full_messages.each { |message| errors.add(:base, message) }
    false
  end

  private

  def prepare_artworks
    @artworks = @urls.split(',').map { |url| Artwork.new(image_url: url, user_id: @user_id) }
  end

  def save_artworks
    ActiveRecord::Base.transaction do
      @artworks.each do |artwork|
        artwork.save!(validate: false)
      end
    end
  end

end
