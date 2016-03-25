class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :top_level_relationships, :type, :relationship
  end
end
