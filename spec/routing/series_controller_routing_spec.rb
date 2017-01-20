require 'rails_helper'

RSpec.describe SeriesController, type: :routing do

  it { expect(get: '/artists/1/series/1').to route_to(controller: 'series', action: 'show', artist_id: '1', id: '1') }
end
