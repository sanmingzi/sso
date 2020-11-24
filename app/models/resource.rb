class Resource < ApplicationRecord
  NAME_REGEX = /[A-Za-z][A-Za-z0-9_]+/i
  validates :name, presence: true, uniqueness: true, format: NAME_REGEX
end
