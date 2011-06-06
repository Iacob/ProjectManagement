class CreateTeams < ActiveRecord::Migration
  def self.up
    create_table :teams do |t|
      t.integer :id
      t.string :name

      t.timestamps
    end

    create_table :team_user do |t|
      t.integer :team_id
      t.integer :user_id
    end
  end

  def self.down
    drop_table :teams
    drop_table :team_user
  end
end
