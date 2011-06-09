class Team < ActiveRecord::Base
  #set_table_name :team
  has_and_belongs_to_many :user, :join_table => :team_user, :uniq => true
end
