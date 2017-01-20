require 'rails_helper'

RSpec.describe My::FeedsController, type: :routing do

  it { expect(get: '/my/feed').to route_to(controller: 'my/feeds', action: 'show') }

  it { expect(put: '/my/feed').not_to route_to(controller: 'my/feeds', action: 'update') }
  it { expect(patch: '/my/feed').not_to route_to(controller: 'my/feeds', action: 'update') }
  it { expect(post: '/my/feed').not_to be_routable }
  it { expect(delete: '/my/feed').not_to be_routable }

end
