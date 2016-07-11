require "nokogiri"

class RequestCards
  class << self
    def request(params, user)
      if user.blocks.empty?
        block = user.blocks.create(title: "Block for cards from remote url")
      end
      page = Nokogiri::HTML(open(params[:remote_url]))
      if send_request(params, user, page)
        CardsMailer.notify(user.email).deliver_now
      end
    end

    private

    def send_request(params, user, page)
      page.css(params[:row_selector]).each do |row|
        original_word = row.css(params[:original_selector]).text
        translated_word = row.css(params[:translate_selector]).text
        Card.create(original_text: original_word,
                    translated_text: translated_word,
                    user_id: user.id, block_id: user.blocks.first.id)
      end
    end
  end
end
