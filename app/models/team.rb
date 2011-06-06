class Team < ActiveRecord::Base
  has_and_belongs_to_many :user, :join_table => :team_user, :uniq => true
end
