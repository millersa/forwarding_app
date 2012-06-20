class Company < ActiveRecord::Base

	attr_accessible :organization, :contlico, :phone, :gruz #перечень атрибутов, которые будут доступны

	validates :organization, :presence => true #поле обязательно для заполнения
	validates :contlico, :presence => true
	validates :phone, :presence => true
	validates :user_id, :presence => true #поле обязательно для заполнения

	belongs_to :user #создает отношение один-к-одному с моделью  user
	has_many :tenders #создает отношение один-ко-многим с моделью tenders
	has_many :grades, :as => :gradable

	def self.search(search)
	if search
		where('organization LIKE ? OR phone LIKE ?', "#{search}", "#{search}")
	else
		scoped
	end
	
end
end
