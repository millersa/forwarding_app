class Tender < ActiveRecord::Base

	attr_accessible :company_id, :driver_id, :user_id, :status, :price, :form_oplata, :route, :adress_pogruzka, 
	:adress_razgruzki, :gruzotpravitel, :gruzopoluhatel, :date_pogruzki, :vremy_pogruzki, :data_razgruzki, :vremy_razgruzlki,
	:nomer_tender, :forma_oplati2

	validates :company_id, :presence => true
	validates :price, :presence => true
	validates :form_oplata, :presence => true
	validates :route, :presence => true
	validates :adress_pogruzka, :presence => true
	validates :adress_razgruzki, :presence => true
	validates :gruzotpravitel, :presence => true
	validates :date_pogruzki, :presence => true
	validates :data_razgruzki, :presence => true
	validates :nomer_tender, :presence => true
	validates :forma_oplati2, :presence => true



	belongs_to :driver
	belongs_to :company
	belongs_to :user

end
