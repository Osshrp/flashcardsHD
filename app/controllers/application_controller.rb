class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :set_locale
  after_action :track_page_visits

  def find_card(id)
    if id
      @card = current_user.cards.find id
    elsif
      current_user.current_block
      @card = current_user.current_block.cards.pending.first
      @card ||= current_user.current_block.cards.repeating.first
    else
      @card = current_user.cards.pending.first
      @card ||= current_user.cards.repeating.first
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def admin_logout
    logout
  end

  def set_admin_locale
    I18n.locale = :en
  end

  private

  def set_locale
    locale = if current_user
               current_user.locale
             elsif params[:user_locale]
               params[:user_locale]
             elsif session[:locale]
               session[:locale]
             else
               http_accept_language.compatible_language_from(I18n.available_locales)
             end

    if locale && I18n.available_locales.include?(locale.to_sym)
      session[:locale] = I18n.locale = locale
    else
      session[:locale] = I18n.locale = I18n.default_locale
    end
  end

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end

  def track_page_visits
    ahoy.track "User visit page", url: request.env['PATH_INFO']
  end
end
