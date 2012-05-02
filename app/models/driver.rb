 #coding: utf-8
class Driver < ActiveRecord::Base

	attr_accessible :fname, :lname, :oname, :phone, :marka_id, :tipkuzova, :rastentovka, :ves, :objem, :gosnomer, :gosnomerp, :seriy, :nomerp, :kemvidan, :kogdavidan, :contacts

	#validates :fname, :presence => true
	#validates :lname, :presence => true
	#validates :oname, :presence => true
	#validates :phone, :presence => true
	#validates :marka, :inclusion => { :in => [true], :message => "не должно быть пустым" }
	validates :marka_id, :presence => true					
	#validates :tipkuzova, :presence => true
	#validates :rastentovka, :presence => true
	#validates :ves, :presence => true
	#validates :objem, :presence => true
	#validates :gosnomer, :presence => true
	#validates :gosnomerp, :presence => true
	#validates :seriy, :presence => true
	#validates :nomerp, :presence => true
	#validates :kemvidan, :presence => true
	#validates :kogdavidan, :presence => true
	has_many :tenders
	belongs_to :marka

end
