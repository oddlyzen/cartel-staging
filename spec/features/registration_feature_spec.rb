require 'rails_helper'

RSpec.feature 'Registration Feature' do

  describe 'New Registration' do

    before :each do
      Capybara.javascript_driver = :webkit
      Capybara.current_driver = Capybara.javascript_driver
    end

    let(:user) { FactoryGirl.create(:user) }

    scenario 'Never participate in public exhibition' do
      visit new_registration_path
      click_button("I'm an artist")
      click_button('No')
      expect(page).to have_css('.modal', text: 'Thank you for your interest')
    end

    scenario 'Fill all fields as role artist', js: true do

      visit new_registration_path

      select 'Mr', from: 'registration_form[user_attributes][title]'
      fill_in 'First Name', with: user.first_name
      fill_in 'Last Name', with: user.last_name
      fill_in 'registration_form[user_attributes][email]', with: 'hello@pan.com'
      fill_in 'registration_form[user_attributes][password]', with: '123123123'
      fill_in 'registration_form[user_attributes][password_confirmation]', with: '123123123'
      select 'Citizen', from: 'registration_form[user_attributes][residency_status]'
      click_button("I'm an artist")
      click_button('Yes')

      select 'Other', from: 'registration_form[user_attributes][current_status]'

      fill_in 'registration_form[other_current_status_string]', with: 'Tinkerbox'

      find('.registration_form_user_exhibitions_title input').set(user.exhibit_title)
      find('.registration_form_user_exhibitions_link input').set(user.link)

      find(:css, '#artist_acknowledgement').set(true)
      click_button('Register')

      expect(page).to have_content 'Thank you for registering'
      expect(page) == root_path

    end

    scenario 'Fill all fields as role professional', js: true do

      visit new_registration_path
      select 'Mr', from: 'registration_form[user_attributes][title]'
      fill_in 'First Name', with: user.first_name
      fill_in 'Last Name', with: user.last_name
      fill_in 'registration_form[user_attributes][email]', with: 'hellopro@pan.com'
      fill_in 'registration_form[user_attributes][password]', with: '123123123'
      fill_in 'registration_form[user_attributes][password_confirmation]', with: '123123123'
      select 'Citizen', from: 'registration_form[user_attributes][residency_status]'
      click_button("I'm a professional")
      click_button('Yes')
      select 'Seeking work', from: 'registration_form[user_attributes][current_status]'
      find(:css, '#professional_acknowledgement').set(true)
      click_button('Register')
      expect(page).to have_content 'Thank you for registering'
      expect(page) == root_path

    end

  end

end
