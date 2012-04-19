class Company < ActiveRecord::Base

	validates :organization, :presence => true
	validates :contlico, :presence => true
	validates :phone, :presence => true
end
