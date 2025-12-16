class AddConfirmableToDevise < ActiveRecord::Migration[7.1]
  def up
    # Agregar campos de Devise confirmable
    add_column :users, :confirmation_token, :string
    add_column :users, :confirmed_at, :datetime
    add_column :users, :confirmation_sent_at, :datetime
    add_column :users, :unconfirmed_email, :string
    
    add_index :users, :confirmation_token, unique: true
    
    # Eliminar el campo email_verified que ya no usaremos
    remove_column :users, :email_verified
    
    # Confirmar todos los usuarios existentes automáticamente
    User.update_all(confirmed_at: Time.current)
  end
  
  def down
    remove_column :users, :confirmation_token
    remove_column :users, :confirmed_at
    remove_column :users, :confirmation_sent_at
    remove_column :users, :unconfirmed_email
    
    add_column :users, :email_verified, :boolean, default: false, null: false
  end
end
