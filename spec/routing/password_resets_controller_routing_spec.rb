require 'rails_helper'

RSpec.describe PasswordResetsController, type: :routing do

  it { expect(post: 'password_resets').to route_to(controller: 'password_resets', action: 'create') }

  it do
    expect(get: 'password_resets/new-token/edit').to route_to(
      controller: 'password_resets',
      action: 'edit',
      id: 'new-token'
    )
  end

  it do
    expect(patch: 'password_resets/new-token').to route_to(
      controller: 'password_resets',
      action: 'update',
      id: 'new-token'
    )
  end

  it do
    expect(put: 'password_resets/new-token').to route_to(
      controller: 'password_resets',
      action: 'update',
      id: 'new-token'
    )
  end

end
