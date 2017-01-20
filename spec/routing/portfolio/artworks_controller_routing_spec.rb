require 'rails_helper'

RSpec.describe Portfolio::ArtworksController, type: :routing do

  it do
    expect(get: 'portfolio/series/1/artworks').to route_to(
      controller: 'portfolio/artworks',
      action: 'index',
      series_id: '1'
    )
  end

  it do
    expect(patch: 'portfolio/series/1/artworks/1').to route_to(
      controller: 'portfolio/artworks',
      action: 'update',
      series_id: '1',
      id: '1'
    )
  end

  it do
    expect(put: '/portfolio/series/1/artworks/1').to route_to(
      controller: 'portfolio/artworks',
      action: 'update',
      series_id: '1',
      id: '1'
    )
  end

  it do
    expect(delete: '/portfolio/series/1/artworks/bulk_destroy').to route_to(
      controller: 'portfolio/artworks',
      action: 'bulk_destroy',
      series_id: '1'
    )
  end

  it do
    expect(get: '/portfolio/artworks/upload').to route_to(
      controller: 'portfolio/artworks',
      action: 'upload'
    )
  end

  it do
    expect(get: '/portfolio/artworks/upload?series_id=1').to route_to(
      controller: 'portfolio/artworks',
      action: 'upload',
      series_id: '1'
    )
  end

  it do
    expect(post: '/portfolio/artworks/bulk_upload').to route_to(
      controller: 'portfolio/artworks',
      action: 'bulk_upload'
    )
  end

  it do
    expect(post: '/portfolio/artworks/bulk_group').to route_to(
      controller: 'portfolio/artworks',
      action: 'bulk_group'
    )
  end

  it { expect(post: '/portfolio/series/1/artworks').not_to be_routable }

end
