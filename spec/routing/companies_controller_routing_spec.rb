require 'rails_helper'

RSpec.describe CompaniesController, type: :routing do

  it { expect(get: 'organisations').to route_to(controller: 'companies', action: 'index') }
  it { expect(get: '/organisations/1').to route_to(controller: 'companies', action: 'show', id: '1') }

  it { expect(post: '/organisations').not_to be_routable }
  it { expect(put: '/organisations/1').not_to be_routable }
  it { expect(delete: '/organisations/1').not_to be_routable }

end
