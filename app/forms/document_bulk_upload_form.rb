class DocumentBulkUploadForm < BaseForm

  attr_accessor :urls, :artwork_id, :titles

  def initialize(params = {})
    @artwork_id = params[:artwork_id]
    @urls = params[:urls]
    @titles = params[:titles]
  end

  def save
    unless @urls.nil? || @urls.blank?
      prepare_documents
      save_documents
    end
  rescue ActiveRecord::RecordInvalid => e
    e.record.errors.full_messages.each { |message| errors.add(:base, message) }
    false
  end

  private

  def prepare_documents
    @documents = @urls.split(',').map.with_index { |url, i| Document.new(url: url, artwork_id: @artwork_id, title: @titles.split(',')[i]) }
  end

  def save_documents
    ActiveRecord::Base.transaction do
      @documents.each do |document|
        document.save!
      end
    end
  end

end
