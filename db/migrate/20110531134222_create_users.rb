class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :user do |t|
      t.integer :id
      t.string :name
      t.string :login
      t.string :crypted_password
      t.integer :team_id
      t.string :email

      t.timestamps
    end
  end

  def self.down
    drop_table :user
  end
end
