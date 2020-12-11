class UserRole < ApplicationRecord
  include Statusable

  belongs_to :user
  belongs_to :role
  validates :role_id, uniqueness: {scope: :user_id}

  delegate :name, to: :user, prefix: true
  delegate :name, to: :role, prefix: true
end
