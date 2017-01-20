require 'rails_helper'

RSpec.describe LocationsController, type: :routing do

  it { expect(get: '/locations/MY').to route_to(controller: 'locations', action: 'show', id: 'MY') }

  it { expect(get: '/locations').not_to be_routable }
  it { expect(post: '/locations').not_to be_routable }
  it { expect(put: '/locations/1').not_to be_routable }
  it { expect(delete: '/location/1').not_to be_routable }
end
