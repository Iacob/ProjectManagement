class Workitem < ActiveRecord::Base
  set_table_name :workitem
  has_and_belongs_to_many :projects, :join_table => :task_workitem, :class_name => "Project", :foreign_key => :task_id, :association_foreign_key => :workitem_id, :uniq => true
end
