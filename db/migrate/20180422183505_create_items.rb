class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.string :brand_name
      t.string :quantity
      t.boolean :coupon
      t.text :note
      t.boolean :purchased
      t.boolean :frequency
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
