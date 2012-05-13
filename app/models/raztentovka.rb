class Raztentovka < ActiveRecord::Base
	has_many :categorizations
  has_many :drivers, through: :categorizations
end
