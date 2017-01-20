require 'rails_helper'

RSpec.describe Portfolio::ArtworkCollaboratorsController, type: :routing do
  it do
    expect(patch: 'portfolio/artwork_collaborators/1/accept').to route_to(
      controller: 'portfolio/artwork_collaborators',
      action: 'accept',
      id: '1'
    )
  end

  it do
    expect(patch: 'portfolio/artwork_collaborators/1/reject').to route_to(
      controller: 'portfolio/artwork_collaborators',
      action: 'reject',
      id: '1'
    )
  end

  it { expect(post: '/portfolio/artwork_collaborators/1').not_to be_routable }
  it { expect(get: '/portfolio/artwork_collaborators/1/edit').not_to be_routable }
  it { expect(delete: '/portfolio/artwork_collaborators/1').not_to be_routable }
end
