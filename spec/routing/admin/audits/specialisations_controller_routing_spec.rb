require 'rails_helper'

RSpec.describe Admin::Audits::SpecialisationsController, type: :routing do

  it do
    expect(get: '/admin/audits/specialisations').to route_to(
      controller: 'admin/audits/specialisations',
      action: 'index'
    )
  end

  it do
    expect(get: '/admin/audits/specialisations/1/edit').to route_to(
      controller: 'admin/audits/specialisations',
      action: 'edit',
      id: '1'
    )
  end

  it do
    expect(put: '/admin/audits/specialisations/1').to route_to(
      controller: 'admin/audits/specialisations',
      action: 'update',
      id: '1'
    )
  end

  it do
    expect(patch: '/admin/audits/specialisations/1').to route_to(
      controller: 'admin/audits/specialisations',
      action: 'update',
      id: '1'
    )
  end

  it do
    expect(patch: '/admin/audits/specialisations/1/approve').to route_to(
      controller: 'admin/audits/specialisations',
      action: 'approve',
      id: '1'
    )
  end

  it do
    expect(patch: '/admin/audits/specialisations/1/reject').to route_to(
      controller: 'admin/audits/specialisations',
      action: 'reject',
      id: '1'
    )
  end

  it do
    expect(post: '/admin/audits/specialisations').to route_to(
      controller: 'admin/audits/specialisations',
      action: 'create'
    )
  end

end
