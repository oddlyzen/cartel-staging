class SeriesUpdateForm < BaseForm

  attr_accessor :id, :series, :exhibition, :user_id

  delegate :attributes=,  to: :series, prefix: true
  delegate :attributes=,  to: :exhibition, prefix: true

  validate :series_is_valid?, on: :publish
  validate :artworks_are_valid?, on: :publish

  def initialize(params = {})
    @user = User.find(params[:user_id])
    @series = @user.series.find(params[:id])
    @exhibition = @user.exhibitions.build
    super(params)
  end

  def save
    if valid?
      ActiveRecord::Base.transaction do
        create_exhibition
        @series.save!
      end
    end
    errors.empty?
  rescue ActiveRecord::RecordInvalid => e
    errors.add(:base, e.message) and return false
  end

  def publish
    if valid?(:publish)
      ActiveRecord::Base.transaction do
        create_exhibition
        @series.save!
        @series.publish!
        @series.feed_items.create(user: @user, kind: :series_published)
      end
    end
    errors.empty?
  rescue ActiveRecord::RecordInvalid => e
    e.record.errors.full_messages.each { |message| errors.add(:base, message) }
    false
  end

  private

  def series_is_valid?
    errors.add('Series:', @series.errors.full_messages.to_sentence) unless @series.valid?(:publish)
  end

  def create_exhibition
    return if @exhibition.attributes.except('user_id').values.all?(&:blank?)
    @exhibition.save!
    @series.exhibition_id = @exhibition.id
  end

  def artworks_are_valid?
    unless @series.artworks.blank?
      artwork_errors = @series.artworks.flat_map do |artwork|
        artwork.errors.full_messages unless artwork.valid?(:series_save)
      end.flatten.compact.uniq
      errors.add('Series: ' + 'Artwork: ', artwork_errors.to_sentence) if artwork_errors.present?
    end
  end

end
