class User < ActiveRecord::Base
	attr_accessible :username, :phone, :firstname, :lastname, :otchestvo, :sex, :datebirth, :doljnost, :datework, :seriy, :nomer, :vidan, :password, :password_confirmation
  has_secure_password

  	validates :firstname, :presence => true
  	validates :username, :presence => true,
  						 :length   => { :maximum => 30 },
  						 :uniqueness => { :case_sensitive => false }
  	validates :phone, :presence => true
  	validates :lastname, :presence => true
  	validates :otchestvo, :presence => true
  	validates :sex, :presence => true
  	validates :datebirth, :presence => true
  	validates :doljnost, :presence => true
  	validates :datework, :presence => true
  	validates :seriy, :presence => true,
  					  :length   => { :maximum => 4 }
  	validates :nomer, :presence => true,
  					  :length   => { :maximum => 6 }
  	validates :vidan, :presence => true

    validates :password, length: { minimum: 6 }
    validates :password_confirmation, presence: true

   before_save :create_remember_token

   private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end

