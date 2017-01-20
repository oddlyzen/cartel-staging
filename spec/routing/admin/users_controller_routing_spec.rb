require 'rails_helper'

RSpec.describe Admin::UsersController, type: :routing do

  it { expect(get: '/admin/users').to route_to(controller: 'admin/users', action: 'index') }

  it { expect(get: '/admin/users/1').to route_to(controller: 'admin/users', action: 'show', id: '1') }
  it { expect(post: '/admin/users').not_to be_routable }

  it { expect(put: '/admin/users/1/activate').to route_to(controller: 'admin/users', action: 'activate', id: '1') }
  it { expect(put: '/admin/users/1/deactivate').to route_to(controller: 'admin/users', action: 'deactivate', id: '1') }

  it { expect(delete: '/admin/users/1').not_to be_routable }
  it { expect(patch: '/admin/users/1').not_to be_routable }

end
