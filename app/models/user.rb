
class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :cuenta, :telefono, :informacion_adicional, :name, :career_id, :role_id, :avatar
  mount_uploader :avatar, AvatarUploader
	belongs_to :role
	belongs_to :career
  
  attr_accessor :password
  before_save :encrypt_password
  
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email
  
  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end


