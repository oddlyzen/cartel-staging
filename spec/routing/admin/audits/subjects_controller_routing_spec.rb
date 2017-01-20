require 'rails_helper'

RSpec.describe Admin::Audits::SubjectsController, type: :routing do

  it do
    expect(get: '/admin/audits/subjects').to route_to(
      controller: 'admin/audits/subjects',
      action: 'index'
    )
  end

  it do
    expect(get: '/admin/audits/subjects/1/edit').to route_to(
      controller: 'admin/audits/subjects',
      action: 'edit',
      id: '1'
    )
  end

  it do
    expect(put: '/admin/audits/subjects/1').to route_to(
      controller: 'admin/audits/subjects',
      action: 'update',
      id: '1'
    )
  end

  it do
    expect(patch: '/admin/audits/subjects/1').to route_to(
      controller: 'admin/audits/subjects',
      action: 'update',
      id: '1'
    )
  end

  it do
    expect(patch: '/admin/audits/subjects/1/approve').to route_to(
      controller: 'admin/audits/subjects',
      action: 'approve',
      id: '1'
    )
  end

  it do
    expect(patch: '/admin/audits/subjects/1/reject').to route_to(
      controller: 'admin/audits/subjects',
      action: 'reject',
      id: '1'
    )
  end

  it do
    expect(post: '/admin/audits/subjects').to route_to(
      controller: 'admin/audits/subjects',
      action: 'create'
    )
  end

end
