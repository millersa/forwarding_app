class Role < ActiveRecord::Base
  #has_and_belongs_to_many :users, :join_table => :users_roles
  #belongs_to :resource, :polymorphic => true
    has_many :assignments
  has_many :users, :through => :assignments
end
