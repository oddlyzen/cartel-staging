require 'rails_helper'

RSpec.describe Admin::FeedsController, type: :routing do

  it { expect(get: '/admin/feeds').to route_to(controller: 'admin/feeds', action: 'index') }

  it { expect(get: '/admin/feeds/new').to route_to(controller: 'admin/feeds', action: 'new') }
  it { expect(post: '/admin/feeds').to route_to(controller: 'admin/feeds', action: 'create') }

  it { expect(get: '/admin/feeds/1/edit').to route_to(controller: 'admin/feeds', action: 'edit', id: '1') }

  it { expect(delete: '/admin/feeds/1').to route_to(controller: 'admin/feeds', action: 'destroy', id: '1') }
  it { expect(patch: '/admin/feeds/1').to route_to(controller: 'admin/feeds', action: 'update', id: '1') }

end
