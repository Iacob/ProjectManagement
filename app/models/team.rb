class Team < ActiveRecord::Base
  set_table_name :team
  has_and_belongs_to_many :users, \
    :class_name => "User", \
    :foreign_key => :team_id, \
    :association_foreign_key => :user_id, \
    :join_table => :team_user,\
    :uniq => true
end
