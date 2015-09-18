class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :login
      t.string :password_digest
      t.text :description
      t.string :email
      t.boolean :admin

      t.timestamps
    end
  end
end
