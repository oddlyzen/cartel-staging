require 'rails_helper'

RSpec.describe My::TagsController, type: :routing do
  it { expect(post: '/my/tags').to route_to(controller: 'my/tags', action: 'create') }

  it { expect(get: '/my/tags').not_to be_routable }
  it { expect(patch: '/my/tags').not_to be_routable }
  it { expect(put: '/my/tags').not_to be_routable }
  it { expect(delete: '/my/tags').not_to be_routable }
end
