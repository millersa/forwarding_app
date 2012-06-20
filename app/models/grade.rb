class Grade < ActiveRecord::Base
	#attr_accessible :more, :mark
	#validates :mark, :presence => true
	

	belongs_to :gradable, :polymorphic => true
end
