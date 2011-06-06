class CreateWorkitems < ActiveRecord::Migration
  def self.up
    create_table :workitems do |t|
      t.integer :id
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :workitems
  end
end
