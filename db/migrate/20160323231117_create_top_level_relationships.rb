class CreateTopLevelRelationships < ActiveRecord::Migration
  def change
    create_table :top_level_relationships do |t|
      t.references :project, index: true
      t.references :item, index: true
      t.string :type

      t.timestamps
    end
  end
end
