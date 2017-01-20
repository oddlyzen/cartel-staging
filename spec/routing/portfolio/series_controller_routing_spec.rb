require 'rails_helper'

RSpec.describe Portfolio::SeriesController, type: :routing do

  it { expect(get: '/portfolio/series').to route_to(controller: 'portfolio/series', action: 'index') }
  it { expect(get: '/portfolio/series/1').to route_to(controller: 'portfolio/series', action: 'show', id: '1') }
  it { expect(get: '/portfolio/series/1/edit').to route_to(controller: 'portfolio/series', action: 'edit', id: '1') }
  it { expect(patch: '/portfolio/series/1').to route_to(controller: 'portfolio/series', action: 'update', id: '1') }
  it { expect(delete: '/portfolio/series/1').to route_to(controller: 'portfolio/series', action: 'destroy', id: '1') }

  it do
    expect(patch: '/portfolio/series/1/set_cover').to route_to(
      controller: 'portfolio/series',
      action: 'set_cover',
      id: '1'
    )
  end

  it do
    expect(patch: '/portfolio/series/1/publish').to route_to(
      controller: 'portfolio/series',
      action: 'publish',
      id: '1'
    )
  end

  it do
    expect(get: '/portfolio/series/1/rearrange').to route_to(
      controller: 'portfolio/series',
      action: 'rearrange',
      id: '1'
    )
  end

  it do
    expect(patch: '/portfolio/series/1/set_order').to route_to(
      controller: 'portfolio/series',
      action: 'set_order',
      id: '1'
    )
  end

end
