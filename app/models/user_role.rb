class UserRole < ApplicationRecord
  include Statusable

  belongs_to :user
  belongs_to :role
  validates :role_id, uniqueness: {scope: :user_id}
end
