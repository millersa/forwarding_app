 #coding: utf-8
class Driver < ActiveRecord::Base

	attr_accessible :fname, :lname, :oname, :phone, :marka_id, :tipkuzova, :raztentovka_ids, :ves, :objem, :gosnomer, :gosnomerp, 
	:seriy, :nomerp, :kemvidan, :kogdavidan, :contacts, :ownership #перечень атрибутов, которые будут доступны

	validates :fname, :presence => true #поле обязательно для заполнения
	validates :lname, :presence => true
	validates :oname, :presence => true
	validates :phone, :presence => true #поле обязательно для заполнения
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
	validates :kogdavidan, :presence => true #поле обязательно для заполнения

	has_many :tenders #создает отношение один-ко-многим с моделью tenders
	belongs_to :marka #создает отношение один-к-одному с моделью marka
	has_many :grades, :as => :gradable


	has_many :categorizations, :dependent => :destroy 
 	has_many :raztentovkas, through: :categorizations #создает отношение один-ко-многим с моделью tenders

def self.search(search) # поиск
	if search
		where('lname LIKE ? OR phone LIKE ?', "#{search}", "#{search}")
	else
		scoped
	end
	
end


end
