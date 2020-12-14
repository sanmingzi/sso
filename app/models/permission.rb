class Permission < ApplicationRecord
  has_many :role_permissions
  has_many :roles, through: :role_permissions
  belongs_to :action
  belongs_to :resource
  validates :action_id, uniqueness: {scope: :resource_id}

  scope :order_by_resource, -> { order("resources.name DESC") }

  class << self
    def generate(resource)
      Action.all.each do |action|
        create(action_id: action.id, resource_id: resource.id)
      end
    end
  end

  def name
    "#{action.name}_#{resource.name}"
  end
end
