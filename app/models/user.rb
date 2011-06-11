class User < ActiveRecord::Base
  has_and_belongs_to_many :team, :join_table => :team_user, :uniq => true
  attr_accessor :password

  #cattr_reader :per_page
  #@@per_page = 2

end
