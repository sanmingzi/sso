# class Role < ApplicationRecord
#   has_many :role_permissions
#   has_many :permissions, through: :role_permissions

#   validates :name, presence: true
#   validates :terms_of_service, acceptance: {accept: ['TRUE', 'accepted'], message: 'must be abided'}
  
#   attr_accessor :email
#   validates :email, confirmation: true
#   validates :email_confirmation, presence: true
# end

# class Role < ApplicationRecord
#   attr_accessor :legacy_code

#   validates :legacy_code, format: {with: /\A[a-zA-Z]+\z/, message: "only allows letters"}
# end

# class Role < ApplicationRecord
#   attr_accessor :is_admin

#   validate :common_name_can_not_be_admin

#   def common_name_can_not_be_admin
#     if is_admin == false && name == 'admin'
#       errors.add(:name, 'common name can not be admin')
#     end
#   end
# end
