class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    else
      can [:index, :create , :order_history], Order
      can :show, Order, user_id: user.id
      can :create, OrderDetail
      can :read, OrderDetail
      can :read, Product
      can :read, Category
    end
  end
end
