require 'rails_helper'

RSpec.describe My::ProfilesController, type: :routing do

  it { expect(get: '/my/profile/edit').to route_to(controller: 'my/profiles', action: 'edit') }
  it { expect(put: '/my/profile').to route_to(controller: 'my/profiles', action: 'update') }
  it { expect(patch: '/my/profile').to route_to(controller: 'my/profiles', action: 'update') }

  it { expect(post: '/my/profile').not_to be_routable }
  it { expect(delete: '/my/profile').not_to be_routable }

end
