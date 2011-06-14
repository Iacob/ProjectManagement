class Report < ActiveRecord::Base
  set_table_name :report
  belongs_to :user, :class_name => "User", :foreign_key => :user_id
  belongs_to :project, :class_name => "Project", :foreign_key => :task_id
  belongs_to :workitem, :class_name => "Workitem", :foreign_key => :workitem_id
end
