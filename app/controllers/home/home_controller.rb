class Home::HomeController < Home::BaseController

  def index
    find_card params[:id]
  end
end
