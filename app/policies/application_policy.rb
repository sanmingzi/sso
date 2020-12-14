class ApplicationPolicy
  attr_reader :user, :record
  attr_reader :context

  def initialize(context, record)
    @context = context
    @record = record
  end

  delegate :user, to: :context
  delegate :session, to: :context

  def index?
    true
  end

  def show?
    true
  end

  def create?
    authorized?(__method__)
  end

  def new?
    create?
  end

  def retrieve?
    # authorized?(__method__)
    true
  end

  def search?
    retrieve?
  end

  def update?
    authorized?(__method__)
  end

  def edit?
    update?
  end

  def delete?
    authorized?(__method__)
  end

  def destroy?
    delete?
  end

  def is_admin?
    user.admin? || has_role?('admin')
  end

  def has_role?(r)
    session[:roles].include?(r)
  end

  def has_permission?(p)
    session[:permissions].include?(p)
  end

  def action_name(method)
    method.to_s.chop
  end

  def resource_name
    class_name = record.class.name
    class_name = record.name if record.is_a? Class
    class_name.demodulize.underscore
  end

  def authorized?(method)
    nil != user && (is_admin? || has_permission?("#{action_name(method)}_#{resource_name}"))
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end
end
