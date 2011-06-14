class CreateReports < ActiveRecord::Migration
  def self.up
    create_table :report do |t|
      t.integer :id
      t.date :date
      t.string :description
      t.integer :hours
      t.integer :task_id
      t.integer :user_id
      t.integer :workitem_id

      t.timestamps
    end
  end

  def self.down
    drop_table :report
  end
end
