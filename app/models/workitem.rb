class Workitem < ActiveRecord::Base
  has_and_belongs_to_many :projects, :join_table => :project_workitem, :uniq => true
end
