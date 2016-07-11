class RemoteWordsJob < ActiveJob::Base
  queue_as :default

  def perform(params, user)
    require 'nokogiri'
    # require 'open-uri'
    page = Nokogiri::HTML(open(params[:remote_url]))
    page.css(params[:row_selector]).each do |row|
      original_word = row.css(params[:original_selector]).text
      translated_word = row.css(params[:translate_selector]).text
      card = Card.new(original_text: original_word,
                      translated_text: translated_word,
                      user_id: user.id, block_id: user.blocks.first.id)
      card.save
    end
  end
end
