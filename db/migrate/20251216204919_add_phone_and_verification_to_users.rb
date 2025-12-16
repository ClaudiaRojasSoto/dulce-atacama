class AddPhoneAndVerificationToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :phone, :string
    add_column :users, :phone_verified, :boolean, default: false, null: false
    add_column :users, :email_verified, :boolean, default: false, null: false
    add_column :users, :full_name, :string
    
    add_index :users, :phone
  end
end
