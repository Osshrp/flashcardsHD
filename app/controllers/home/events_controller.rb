class Home::EventsController < Home::BaseController

  def index
    if current_user.has_role? :analit
    else
      redirect_to root_path
    end
  end
end