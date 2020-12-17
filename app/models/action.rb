class Action < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
