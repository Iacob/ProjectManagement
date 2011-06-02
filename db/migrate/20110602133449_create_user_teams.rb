class CreateUserTeams < ActiveRecord::Migration
  def self.up
    create_table :user_teams do |t|
      t.integer :id
      t.integer :team_id
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :user_teams
  end
end
