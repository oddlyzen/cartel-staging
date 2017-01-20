require 'rails_helper'

RSpec.feature 'Session Feature' do

  describe 'Log In' do

    let(:user) { FactoryGirl.create(:user) }

    scenario 'Sign in with correct credentials' do

      visit root_path

      within(:css, '.sessions-new') do
        fill_in 'Email', with: user.email
        fill_in 'Password', with: '123123123'
      end

      click_button 'Log in'
      expect(page).to have_content user.first_name

    end

    scenario 'Sign in with no credentials' do

      visit root_path

      within(:css, '.sessions-new') do
        fill_in 'Email', with: ''
        fill_in 'Password', with: ''
      end

      click_button 'Log in'
      expect(page).to have_content 'We\'re sorry, but this user has not been registered on Cartel'

    end

  end

end
