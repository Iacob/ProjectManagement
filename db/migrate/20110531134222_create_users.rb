class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.integer :id
      t.string :encrypted_passwd
      t.integer :team_id

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
