# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    
    if user.isAdmin?
      can :manage, User  # Admin can view and manage all users
    else
      can :read, User, id: user.id  # Regular users can only read their own profile
    end
  end
end
