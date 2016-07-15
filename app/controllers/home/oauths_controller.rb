class Home::OauthsController < Home::BaseController
  # sends the user on a trip to the provider,
  # and after authorizing there back to the callback url.
  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    if @user = login_from(provider)
      ahoy.authenticate(@user)
      track_provider
      to_trainer_path
    else
      begin
        @user = create_from(provider)
        reset_session
        auto_login(@user)
        ahoy.authenticate(@user)
        track_provider
        to_trainer_path
      rescue
        redirect_to user_sessions_path, alert: (t 'log_out_failed_provider_alert',
                                        provider: provider.titleize)
      end
    end
  end

  private

  def auth_params
    params.permit(:code, :provider)
  end

  def track_provider
    ahoy.track "remote_sing_in:#{@user.email}"
  end

  def to_trainer_path
    redirect_to trainer_path, notice: (t 'log_in_is_successful_provider_notice',
                              provider: provider.titleize)
  end
end
