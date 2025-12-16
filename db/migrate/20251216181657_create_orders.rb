class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.string :status
      t.decimal :total
      t.text :delivery_address
      t.datetime :delivery_date
      t.string :phone
      t.text :notes

      t.timestamps
    end
  end
end
