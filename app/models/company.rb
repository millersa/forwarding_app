class Company < ActiveRecord::Base

	attr_accessible :organization, :contlico, :phone, :gruz

	validates :organization, :presence => true
	validates :contlico, :presence => true
	validates :phone, :presence => true
	validates :user_id, :presence => true

	belongs_to :user
	has_many :tenders
end
