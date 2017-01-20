require 'rails_helper'

RSpec.describe My::CompaniesController, type: :routing do

  it { expect(get: '/my/organisations').to route_to(controller: 'my/companies', action: 'index') }
  it { expect(get: '/my/organisations/new').to route_to(controller: 'my/companies', action: 'new') }
  it { expect(post: '/my/organisations').to route_to(controller: 'my/companies', action: 'create') }

  it { expect(delete: '/my/organisations/1').not_to be_routable }

  it { expect(get: '/my/organisations/1/edit').to route_to(controller: 'my/companies', action: 'edit', id: '1') }

  it { expect(put: '/my/organisations/1').to route_to(controller: 'my/companies', action: 'update', id: '1') }
  it { expect(patch: '/my/organisations/1').to route_to(controller: 'my/companies', action: 'update', id: '1') }

end
