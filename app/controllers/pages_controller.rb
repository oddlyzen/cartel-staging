class PagesController < ApplicationController
  layout :set_layout

  def about
  end

  def contact_us
  end

  def terms_and_conditions
  end

  def privacy_policy
  end

  private

  def set_layout
    current_user ? 'application' : 'landing'
  end
end
