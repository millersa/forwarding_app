class Tender < ActiveRecord::Base

	attr_accessible :company_id, :driver_id, :user_id, :status, :price, :form_oplata, :route, :adress_pogruzka, :adress_razgruzki, :gruzotpravitel, :gruzopoluhatel

	validates :company_id, :presence => true
	validates :price, :presence => true
	validates :form_oplata, :presence => true
	validates :route, :presence => true
	validates :adress_pogruzka, :presence => true
	validates :adress_razgruzki, :presence => true
	validates :gruzotpravitel, :presence => true
	validates :gruzopoluhatel, :presence => true


	belongs_to :driver
	belongs_to :company
	belongs_to :user

end
