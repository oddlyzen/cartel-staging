require 'rails_helper'

RSpec.describe ArtworksController, type: :routing do

  it { expect(get: '/artists/1/artworks').to route_to(controller: 'artworks', action: 'index', artist_id: '1') }

  it { expect(post: '/artists/1/artworks').not_to be_routable }
  it { expect(delete: '/artists/1/artworks/1').not_to be_routable }
  it { expect(get: '/artists/1/artworks/1/edit').not_to be_routable }

  it { expect(put: '/artists/1/artworks/1').not_to be_routable }
  it { expect(patch: '/artists/1/artworks/1').not_to be_routable }

end
