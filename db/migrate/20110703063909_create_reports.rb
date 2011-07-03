class CreateReports < ActiveRecord::Migration
  def self.up
    create_table :reports do |t|
      t.integer :user_id
      t.integer :task_id
      t.integer :workitem_id
      t.integer :hours
      t.date :date

      t.timestamps
    end
  end

  def self.down
    drop_table :reports
  end
end
