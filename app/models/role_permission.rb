class RolePermission < ApplicationRecord
  include Statusable

  belongs_to :role
  belongs_to :permission
  validates :role_id, uniqueness: {scope: :permission_id}

  delegate :name, to: :role, prefix: true
  delegate :name, to: :permission, prefix: true
end
