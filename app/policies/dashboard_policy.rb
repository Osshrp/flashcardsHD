class DashboardPolicy < ApplicationPolicy

  def dashboard?
    false
  end

  def index?
    false
  end
end