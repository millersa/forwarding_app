class Way < ActiveRecord::Base
	has_many :tenders #создает отношение один-ко-многим с моделью tenders
end 
