class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :task do |t|
      t.integer :id
      t.string :name
      t.string :description
      t.date :start_date
      t.date :end_date

      t.timestamps
    end

    create_table :task_workitem do |t|
      t.integer :task_id
      t.integer :workitem_id
    end

    create_table :team_task do |t|
      t.integer :team_id
      t.integer :task_id
    end
  end

  def self.down
    drop_table :task
    drop_table :task_workitem
  end
end
