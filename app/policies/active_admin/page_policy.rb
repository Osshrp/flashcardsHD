class ActiveAdmin::PagePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    false
  end

  def show?
    false
  end
end
