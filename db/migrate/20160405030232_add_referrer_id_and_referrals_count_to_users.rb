class AddReferrerIdAndReferralsCountToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :referrer, index: true
    add_column :users, :referrals_count, :integer, default: 0
  end
end
