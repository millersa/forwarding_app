class User < ActiveRecord::Base
	#rolify
  
	attr_accessible :username, :roles, :phone, :firstname, :lastname, :otchestvo, :sex, :datebirth, :doljnost, :datework, :seriy, :nomer, :vidan, :password, :password_confirmation
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

   has_many :companies
   has_many :tenders

  scope :with_role, lambda { |role| {:conditions => "roles_mask & #{2**ROLES.index(role.to_s)} > 0"} }
  
  ROLES = %w[sadmin admin worker]
  
  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end
  
  def roles
    ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  end
  
  def role?(role)
    roles.include? role.to_s
  end

   private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end

