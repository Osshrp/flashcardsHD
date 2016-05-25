class ActiveAdmin::CommentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end


  def index?
    #user.has_role? :admin2
    false
  end

  def show
    false
  end

  def create?
    user.has_role? :admin2
  end

  def new?
    create?
  end

  def update?
    user.has_role? :admin2
  end

  def edit?
    update?
  end

  def destroy?
    user.has_role? :admin2
  end

  end
end
