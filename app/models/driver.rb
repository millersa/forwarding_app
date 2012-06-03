 #coding: utf-8
class Driver < ActiveRecord::Base

	attr_accessible :fname, :lname, :oname, :phone, :marka_id, :tipkuzova, :raztentovka_ids, :ves, :objem, :gosnomer, :gosnomerp, :seriy, :nomerp, :kemvidan, :kogdavidan, :contacts

	validates :fname, :presence => true
	validates :lname, :presence => true
	validates :oname, :presence => true
	validates :phone, :presence => true
	#validates :marka, :inclusion => { :in => [true], :message => "не должно быть пустым" }
	#validates :marka_id, :presence => true					
	validates :tipkuzova, :presence => true
	validates :raztentovka_ids, :presence => true
	validates :ves, :presence => true
	validates :objem, :presence => true
	validates :gosnomer, :presence => true
	validates :gosnomerp, :presence => true
	validates :seriy, :presence => true
	validates :nomerp, :presence => true
	validates :kemvidan, :presence => true
	validates :kogdavidan, :presence => true

	has_many :tenders
	belongs_to :marka 
	#belongs_to :raztentovka

	#serialize :rastentovka_ids, Array

	has_many :categorizations, :dependent => :destroy
 	has_many :raztentovkas, through: :categorizations
	#before_validation :update_rastentovka_ids

	#def update_rastentovka_ids
	#  if rastentovka_ids_changed? and !rastentovka_ids.is_a?(Array)
	#    self.rastentovka_ids = self.rastentovka_ids.split(',').collect(&:strip) 
	#  end
	#end

#before_validation :update_rastentovka_ids

#def update_rastentovka_ids
 # self.rastentovka_ids = self.rastentovka_ids.split(",").map(&:strip) if self.rastentovka_ids.is_a?(String)
#end




end
