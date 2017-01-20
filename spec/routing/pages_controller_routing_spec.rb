require 'rails_helper'

RSpec.describe PagesController, type: :routing do

  it { expect(get: 'about').to route_to(controller: 'pages', action: 'about') }
  it { expect(get: 'contact-us').to route_to(controller: 'pages', action: 'contact_us') }
  it { expect(get: 'terms-and-conditions').to route_to(controller: 'pages', action: 'terms_and_conditions') }
  it { expect(get: 'privacy-policy').to route_to(controller: 'pages', action: 'privacy_policy') }
end
