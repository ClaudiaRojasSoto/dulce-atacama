class CreatePromotions < ActiveRecord::Migration[7.1]
  def change
    create_table :promotions do |t|
      t.string :title
      t.text :description
      t.decimal :discount_percentage
      t.boolean :active
      t.date :valid_from
      t.date :valid_until

      t.timestamps
    end
  end
end
