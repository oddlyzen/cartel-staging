require 'rails_helper'

RSpec.describe My::SettingsController, type: :routing do

  it { expect(get: '/my/settings').to route_to(controller: 'my/settings', action: 'show') }
  it { expect(put: '/my/settings').to route_to(controller: 'my/settings', action: 'update') }
  it { expect(patch: '/my/settings').to route_to(controller: 'my/settings', action: 'update') }

  it { expect(get: '/my/settings/account').to route_to(controller: 'my/settings', action: 'account') }
  it { expect(put: '/my/settings/deactivate').to route_to(controller: 'my/settings', action: 'deactivate') }

  it { expect(post: '/my/settings').not_to be_routable }
  it { expect(delete: '/my/settings').not_to be_routable }

end
