class Role < ApplicationRecord
  include Statusable

  has_many :role_permissions
  has_many :permissions, through: :role_permissions

  validates :name, presence: true, uniqueness: true
end
