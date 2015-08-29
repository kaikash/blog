class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new 

    # Articles controller
    can [:index, :show, :new, :create, :destroy], Article if user.admin?
    can [:index, :show, :new, :create], Article if user.user?
    # raise user.inspect
    can :destroy, Article, user_id: user.id if user.user?
    can [:index, :show], Article if user.guest?

    # Comments controller
    can [:create, :destroy], Comment if user.admin?
    can :create, Comment if user.user?
    can :destroy, Comment, user_id: user.id if user.user?

    can :index, User if user.admin? || user.user?
  end
end
