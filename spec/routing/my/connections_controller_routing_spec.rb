require 'rails_helper'

RSpec.describe My::ConnectionsController, type: :routing do

  it { expect(get: '/my/connections').to route_to(controller: 'my/connections', action: 'index') }
  it { expect(post: '/my/connections').to route_to(controller: 'my/connections', action: 'create') }
  it { expect(put: '/my/connections/1/accept').to route_to(controller: 'my/connections', action: 'accept', id: '1') }
  it { expect(put: '/my/connections/1/reject').to route_to(controller: 'my/connections', action: 'reject', id: '1') }

  it { expect(delete: '/my/connections/1').to be_routable }
  it { expect(put: '/my/connections').not_to be_routable }
  it { expect(patch: '/my/connections').not_to be_routable }

end
