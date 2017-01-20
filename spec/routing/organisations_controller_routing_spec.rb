require 'rails_helper'

RSpec.describe OrganisationsController, type: :routing do

  it do
    expect(get: 'artists/1/organisations').to route_to(
      controller: 'organisations',
      action: 'index',
      artist_id: '1'
    )
  end

  it do
    expect(get: 'professionals/1/organisations').to route_to(
      controller: 'organisations',
      action: 'index',
      professional_id: '1'
    )
  end

end
