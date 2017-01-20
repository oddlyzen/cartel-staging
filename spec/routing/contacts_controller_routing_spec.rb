require 'rails_helper'

RSpec.describe ContactsController, type: :routing do

  it { expect(post: '/interest').to route_to(controller: 'contacts', action: 'interest') }
  it { expect(post: '/enquiry').to route_to(controller: 'contacts', action: 'enquiry') }

  it { expect(get: '/interest').not_to be_routable }
  it { expect(get: '/enquiry').not_to be_routable }
  it { expect(delete: '/interest').not_to be_routable }
  it { expect(delete: '/enquiry').not_to be_routable }
end
