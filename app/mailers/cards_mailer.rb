class CardsMailer < ActionMailer::Base
  default from: ENV['DEFAULT_EMAIL_FROM_CARDS']

  def pending_cards_notification(email)
    mail(to: email, subject: t(:review_date_came_notice))
  end

  def notify (email = 'oss@bobrptd.ru')
    mail(to: email, subject: "Request")
  end
end
