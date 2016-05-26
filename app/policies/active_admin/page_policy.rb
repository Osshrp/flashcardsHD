class ActiveAdmin::PagePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    user.has_role? :admin
  end

  def show?
    user.has_role? :admin
  end
end
