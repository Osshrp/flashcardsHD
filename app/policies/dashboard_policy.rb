class DashboardPolicy < ApplicationPolicy

  def dashboard?
    user.has_role? :admin
  end

  def index?
    user.has_role? :admin
  end
end