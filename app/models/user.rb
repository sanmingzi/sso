require 'digest/sha1'

class User < ApplicationRecord
  include Statusable

  attr_accessor :password

  EMAIL_REGEX = /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i
  validates :username, presence: {message: 'username can\'t be blank'}, uniqueness: {case_sensitive: true}
  validates :email, presence: {message: 'email can\'t be blank'}, uniqueness: {case_sensitive: true}, format: EMAIL_REGEX
  validates :password, presence: {message: 'password can\'t be blank'}, confirmation: true, if: lambda { self.encrypted_password == nil }

  before_save :encrypt_password
  after_save :clear_password

  has_many :user_roles
  has_many :roles, through: :user_roles
  has_many :role_permissions, through: :roles
  has_many :permissions, through: :roles

  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.encrypted_password = BCrypt::Engine.hash_secret(password, salt)
    end
  end

  def clear_password
    self.password = nil
  end

  def authenticate(password)
    BCrypt::Engine.hash_secret(password, self.salt) == self.encrypted_password
  end

  def admin?
    'admin' == self.username
  end
end
