class UserDecorator < BaseDecorator

  def full_name
    "#{@model.first_name} #{@model.last_name}"
  end

  def tag_user_full_name
    "#{@model.user.first_name} #{@model.user.last_name}"
  end

  def media_tags
    profile.media.blank? ? [] : profile.media
  end

  def available_for_commission
    @model.commission? ? 'Yes' : 'No'
  end

  def display_based_in
    if @model.based_state && @model.based_country
      "#{!@model.based_state.blank? ? @model.based_state.humanize + ', ' : ''}#{@model.based_country}"
    end
  end

  def nationality_status
    if @model.nationality_country && @model.residency_status
      "#{@model.nationality_country} #{@model.residency_status.humanize}"
    end
  end

  def display_role
    @model.role.humanize.to_s unless @model.role.blank?
  end

  def link_to_website
    @model.link.blank? ? 'No Website Available' : "http://#{@model.link}"
  end

  def statement_snippet
    truncate(@model.tagline, length: 50)
  end

  def tag_list(tag_type)
    profile.send(tag_type).join(', ').presence || "No #{tag_type.to_s.capitalize} Selected"
  end

  def languages_list
    profile.language_proficiencies.includes(:language).map do |proficiency|
      "#{proficiency.level} #{proficiency.language.name}"
    end.join(', ').presence || 'No Languages Selected'
  end

  def experiences
    ExperienceDecorator.wrap_all(@model.experiences)
  end

  def publications
    PublicationDecorator.wrap_all(@model.publications)
  end

  def all_exhibitions
    @model.exhibitions
  end

  def solo_exhibitions
    @model.exhibitions.in_solo
  end

  def group_exhibitions
    @model.exhibitions.in_group
  end

  def pdf_exhibitions
    @model.exhibitions.with_attachment
  end

  def bibliographies
    BibliographyDecorator.wrap_all(@model.bibliographies)
  end

  def facebook_link
    "http://#{@model.facebook_link}"
  end

  def twitter_link
    "http://#{@model.twitter_link}"
  end

  def instagram_link
    "http://#{@model.instagram_link}"
  end

  def series_count
    @model.artworks.count
  end

  def artworks_count
    @model.artworks.count
  end

  private

  def profile
    @model.profile
  end

end
