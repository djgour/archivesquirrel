class CreateItemRelationships < ActiveRecord::Migration
  def change
    create_table :item_relationships do |t|
      t.references :parent, index: true
      t.references :child, index: true

      t.timestamps
    end
  end
end
