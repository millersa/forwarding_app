class Marka < ActiveRecord::Base
	has_many :drivers #создает отношение один-ко-многим с моделью drivers
end
