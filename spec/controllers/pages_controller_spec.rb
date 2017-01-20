require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe 'GET #about' do
    before { get :about }

    it { is_expected.to render_template(:about) }
    it { is_expected.to respond_with :success }
  end

  describe 'GET #contact_us' do
    before { get :contact_us }

    it { is_expected.to render_template(:contact_us) }
    it { is_expected.to respond_with :success }
  end

  describe 'GET #terms_and_conditions' do
    before { get :terms_and_conditions }

    it { is_expected.to render_template(:terms_and_conditions) }
    it { is_expected.to respond_with :success }
  end

  describe 'GET #privacy_policy' do
    before { get :privacy_policy }

    it { is_expected.to render_template(:privacy_policy) }
    it { is_expected.to respond_with :success }
  end
end
