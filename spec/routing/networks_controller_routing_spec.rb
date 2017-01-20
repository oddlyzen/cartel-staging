require 'rails_helper'

RSpec.describe NetworksController, type: :routing do

  it do
    expect(get: 'artists/1/networks').to route_to(
      controller: 'networks',
      action: 'index',
      artist_id: '1'
    )
  end

  it do
    expect(get: 'professionals/1/networks').to route_to(
      controller: 'networks',
      action: 'index',
      professional_id: '1'
    )
  end

end
