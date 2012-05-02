class Tender < ActiveRecord::Base

belongs_to :driver
belongs_to :company
belongs_to :user

end
