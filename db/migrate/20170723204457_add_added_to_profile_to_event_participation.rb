class AddAddedToProfileToEventParticipation < ActiveRecord::Migration
  def change
    add_column :event_participations, :added_to_profile, :boolean, default: false
  end
end
