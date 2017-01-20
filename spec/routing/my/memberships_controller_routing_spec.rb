require 'rails_helper'

RSpec.describe My::MembershipsController, type: :routing do

  it do
    expect(post: '/my/organisations/1/memberships').to route_to(
      controller: 'my/memberships',
      action: 'create',
      company_id: '1'
    )
  end

  it do
    expect(delete: '/my/organisations/1/memberships').to route_to(
      controller: 'my/memberships',
      action: 'destroy',
      company_id: '1'
    )
  end

  it do
    expect(patch: '/my/organisations/1/memberships/1/approve').to route_to(
      controller: 'my/memberships',
      action: 'approve',
      company_id: '1',
      id: '1'
    )
  end

  it do
    expect(patch: '/my/organisations/1/memberships/1/reject').to route_to(
      controller: 'my/memberships',
      action: 'reject',
      company_id: '1',
      id: '1'
    )
  end

end
