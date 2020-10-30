require 'active_support/concern'

module Activeable
  extend ActiveSupport::Concern

  included do
  end

  class_methods do
  end

  def is_active?
    status == 'Enable'
  end
end

class Role
  include Activeable

  attr_accessor :status

  def initialize(status: 'Enable')
    @status = status
  end
end

class Permission
  include Activeable

  attr_accessor :status

  def initialize(status: 'Disable')
    @status = status
  end
end

puts Role.new.is_active?
puts Permission.new.is_active?

require 'active_support/concern'

module Foo
  extend ActiveSupport::Concern

  included do
    puts self.inspect

    def self.method_injected_by_foo
    end
  end
end

module Bar
  extend ActiveSupport::Concern
  include Foo

  included do
    puts self.inspect
    
    self.method_injected_by_foo
  end
end

class Host
  include Bar # It works, now Bar takes care of its dependencies
end
