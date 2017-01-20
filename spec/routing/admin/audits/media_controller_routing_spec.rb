require 'rails_helper'

RSpec.describe Admin::Audits::MediaController, type: :routing do

  it { expect(get: '/admin/audits/media').to route_to(controller: 'admin/audits/media', action: 'index') }

  it do
    expect(get: '/admin/audits/media/1/edit').to route_to(
      controller: 'admin/audits/media',
      action: 'edit',
      id: '1'
    )
  end

  it { expect(put: '/admin/audits/media/1').to route_to(controller: 'admin/audits/media', action: 'update', id: '1') }

  it { expect(patch: '/admin/audits/media/1').to route_to(controller: 'admin/audits/media', action: 'update', id: '1') }

  it do
    expect(patch: '/admin/audits/media/1/approve').to route_to(
      controller: 'admin/audits/media',
      action: 'approve',
      id: '1'
    )
  end

  it do
    expect(patch: '/admin/audits/media/1/reject').to route_to(
      controller: 'admin/audits/media',
      action: 'reject',
      id: '1'
    )
  end

  it { expect(post: '/admin/audits/media').to route_to(controller: 'admin/audits/media', action: 'create') }

end
