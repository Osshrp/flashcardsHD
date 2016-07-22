class DashboardPolicy < ApplicationPolicy

  def dashboard?
    admin?
  end

  def index?
    admin?
  end
end
