require 'rails_helper'

RSpec.describe My::InvitesController, type: :routing do
  it { expect(post: '/my/invite').to route_to(controller: 'my/invites', action: 'create') }

  it { expect(get: '/my/invite').not_to be_routable }
  it { expect(patch: '/my/invite').not_to be_routable }
  it { expect(put: '/my/invite').not_to be_routable }
  it { expect(delete: '/my/invite').not_to be_routable }
end
