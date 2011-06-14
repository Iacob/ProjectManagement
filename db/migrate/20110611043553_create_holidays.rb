class CreateHolidays < ActiveRecord::Migration
  def self.up
    create_table :holiday do |t|
      t.date :holiday_date
      t.string :descr

      t.timestamps
    end
  end

  def self.down
    drop_table :holiday
  end
end
