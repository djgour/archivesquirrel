class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.references :invitee, index: true
      t.references :inviter, index: true
      t.references :project, index: true

      t.timestamps
    end
  end
end
