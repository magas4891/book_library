class AddDataToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :stripe_customer_id, :string
    add_column :users, :stripe_subscription_id, :string
    add_column :users, :card_last_four, :string
    add_column :users, :card_exp_month, :integer
    add_column :users, :card_exp_year, :integer
    add_column :users, :card_type, :string
    add_column :users, :admin, :boolean
    add_column :users, :subscription, :boolean
  end
end
