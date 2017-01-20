require 'rails_helper'

RSpec.describe Admin::EventsController, type: :routing do

  it { expect(get: '/admin/events').to route_to(controller: 'admin/events', action: 'index') }

  it { expect(get: '/admin/events/1').not_to be_routable }
  it { expect(post: '/admin/events').not_to be_routable }

  it { expect(delete: '/admin/events/1').not_to be_routable }
  it { expect(patch: '/admin/events/1').not_to be_routable }

end
