class UserContext
  attr_reader :user, :session

  def initialize(user, session)
    @user, @session = user, session
  end
end
