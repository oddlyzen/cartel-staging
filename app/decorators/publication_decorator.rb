class PublicationDecorator < BaseDecorator
  include DateFormat
  include ActionView::Helpers::UrlHelper

  def full_title
    if @model.attachment_url.present?
      link_to @model.title, @model.attachment_url, target: '_blank'
    elsif @model.pdf_url.present?
      link_to @model.pdf_url.split('/').last, @model.pdf_url, target: '_blank'
    else
      @model.title
    end
  end

end
