class Driver < ActiveRecord::Base

	validates :fname, :presence => true
	validates :lname, :presence => true
	validates :oname, :presence => true
	validates :phone, :presence => true
	validates :marka, :presence => true
	validates :tipkuzova, :presence => true
	validates :rastentovka, :presence => true
	validates :ves, :presence => true
	validates :objem, :presence => true
	validates :gosnomer, :presence => true
	validates :gosnomerp, :presence => true
	validates :seriy, :presence => true
	validates :nomerp, :presence => true
	validates :kemvidan, :presence => true
	validates :kogdavidan, :presence => true
end
