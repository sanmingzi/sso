require 'active_support/concern'

module Statusable
  extend ActiveSupport::Concern

  included do
    scope :active, -> { where(status: 0) }
    scope :inactive, -> { where("status <> 0") }
  end

  class_methods do
  end

  def is_active?
    self.status == 0
  end

  def active!
    self.status = 0
    save!
  end

  def inactive!
    self.status = 1
    save!
  end
end
