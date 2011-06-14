class CreateWorkitems < ActiveRecord::Migration
  def self.up
    create_table :workitem do |t|
      t.integer :id
      t.string :name
      t.string :descr

      t.timestamps
    end

    create_table :task_workitem do |t|
      t.integer :task_id
      t.integer :workitem_id

      t.timestamps
    end
  end

  def self.down
    drop_table :workitem
    drop_table :task_workitem
  end
end
