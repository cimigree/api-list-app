class CreateJoinTableItemStore < ActiveRecord::Migration[5.2]
  def change
    create_join_table :items, :stores do |t|
      t.index [:item_id, :store_id]
    end
  end
end
