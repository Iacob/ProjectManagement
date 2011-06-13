class Project < ActiveRecord::Base
  set_table_name :task
  has_and_belongs_to_many :workitems, :class_name => "Workitem", :join_table => :task_workitem, :foreign_key => :task_id, :association_foreign_key => :workitem_id, :uniq => true
  has_and_belongs_to_many :teams, :join_table => :team_task, :uniq => true
end
