require 'rails_helper'

RSpec.describe My::PasswordsController, type: :routing do

  it { expect(get: '/my/password').to route_to(controller: 'my/passwords', action: 'show') }
  it { expect(put: '/my/password').to route_to(controller: 'my/passwords', action: 'update') }
  it { expect(patch: '/my/password').to route_to(controller: 'my/passwords', action: 'update') }

  it { expect(post: '/my/password').not_to be_routable }
  it { expect(delete: '/my/password').not_to be_routable }

end
