class CreateWorkitems < ActiveRecord::Migration
  def self.up
    create_table :workitems do |t|
      t.integer :id
      t.string :name

      t.timestamps
    end

    create_table :project_workitem do |t|
      t.integer :project_id
      t.integer :workitem_id

      t.timestamps
    end
  end

  def self.down
    drop_table :workitems
    drop_table :project_workitem
  end
end
