require 'rails_helper'

RSpec.describe Admin::CompaniesController, type: :routing do

  it { expect(get: '/admin/organisations').to route_to(controller: 'admin/companies', action: 'index') }
  it { expect(get: '/admin/organisations/1/edit').to route_to(controller: 'admin/companies', action: 'edit', id: '1') }
  it { expect(put: '/admin/organisations/1').to route_to(controller: 'admin/companies', action: 'update', id: '1') }
  it { expect(patch: '/admin/organisations/1').to route_to(controller: 'admin/companies', action: 'update', id: '1') }

  it { expect(post: '/admin/organisations').not_to be_routable }

  it { expect(delete: '/admin/organisations/1').not_to be_routable }

end
