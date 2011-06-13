class User < ActiveRecord::Base
  set_table_name :user
  has_and_belongs_to_many :teams, :class_name => "Team", :foreign_key => :user_id, :association_foreign_key => :team_id, :join_table => :team_user, :uniq => true
  attr_accessor :password
end
