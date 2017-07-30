module LinkHelper
  URLS = {
    profile: ['artists#show', 'professionals#show'],
    portfolio: ['portfolio#show', 'series#show', 'series#edit', 'series#index', 'artworks#index', 'artworks#edit'],
    network: ['networks#index', 'connections#index'],
    page: ['organisations#index', 'companies#index'],
    artist: ['artists#index'],
    professional: ['professionals#index'],
    company: ['companies#index'],
    event: ['events#index'],
    opportunity: ['opportunities#index']
  }.freeze

  def active(page)
    url = URLS.fetch(page)
    'is-active' if url.include?("#{controller_name}##{action_name}")
  end

  def profile_path(user)
    if user.artist?
      artist_path(user)
    elsif user.professional?
      professional_path(user)
    end
  end

  def pages_path(user)
    if user == current_user
      my_companies_path
    elsif user.artist?
      artist_organisations_path(user)
    elsif user.professional?
      professional_organisations_path(user)
    end
  end

end
