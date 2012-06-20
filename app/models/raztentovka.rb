class Raztentovka < ActiveRecord::Base
	has_many :categorizations #создает отношение один-ко-многим с моделью categorizations
  has_many :drivers, through: :categorizations #создает отношение один-ко-многим с моделью drivers через  categorizations
end
