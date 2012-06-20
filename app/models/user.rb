class User < ActiveRecord::Base
	#rolify
  
	attr_accessible :username, :roles, :phone, :firstname, :lastname, :otchestvo, :sex, :datebirth, :doljnost, :datework, :seriy, :nomer, :vidan, :password, :password_confirmation #перечень атрибутов, которые будут доступны
  has_secure_password # встроенные метод аутентификации

  	validates :firstname, :presence => true # валидация firstname, поле обязательно для заполнения
  	validates :username, :presence => true,
  						 :length   => { :maximum => 30 }, # максимальная длина 30 символов
  						 :uniqueness => { :case_sensitive => false } #уникальное имя
  	validates :phone, :presence => true #поле обязательно для заполнения
  	validates :lastname, :presence => true #поле обязательно для заполнения
  	validates :otchestvo, :presence => true #поле обязательно для заполнения
  	validates :sex, :presence => true #поле обязательно для заполнения
  	validates :datebirth, :presence => true #поле обязательно для заполнения
  	validates :doljnost, :presence => true #поле обязательно для заполнения
  	validates :datework, :presence => true #поле обязательно для заполнения
  	validates :seriy, :presence => true, #поле обязательно для заполнения
  					  :length   => { :maximum => 4 } # максимальная длина 4 символа
  	validates :nomer, :presence => true, #поле обязательно для заполнения
  					  :length   => { :maximum => 6 } #максимальная длина 6 символов
  	validates :vidan, :presence => true #поле обязательно для заполнения

    validates :password, length: { minimum: 6 } #минимальная длина 6 символов
    validates :password_confirmation, presence: true # подтверждение пароля должно совпадать с полем password

   before_save :create_remember_token #перед сохнанеимем вызывается метод  create_remember_token

   has_many :companies #создает отношение один-ко-многим с моделью companies
   has_many :tenders #создает отношение один-ко-многим с моделью tenders

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

    def self.search(search)
  if search
    where('lastname LIKE ? OR phone LIKE ?', "#{search}", "#{search}")
  else
    scoped
  end
  
end
end

