require "rails_helper"
require "support/helpers/login_helper.rb"
include LoginHelper
# require 'pry'
require 'vcr'
require 'pp'

describe "seaching photos in Flickr", vcr: true do
  let!(:user) { create :user_with_one_block_without_cards }
  let!(:card) { Card.create original_text: "house", translated_text: "дом",
               user_id: user.id, block_id: user.blocks.first.id }
  before do
    visit root_path
    login "test@test.com", "12345", "Войти"
    visit edit_card_path card
  end

  it "edit card searching and connecting photos from Flickr" do
    click_link 'Загрузить фото с Flickr'
    fill_in "card_photo_search_string", with: "house"

    VCR.use_cassette 'flickr', :match_requests_on => [:host]  do
      click_button "Искать фото"
    end
    expect(page).to have_xpath "//li/a/img"
  end
end

describe "create card with Flickr photos connected" do
  before do
    user = create :user_with_one_block_without_cards
    visit root_path
    login "test@test.com", "12345", "Войти"
    visit new_card_path
  end

  it "create card searching and connecting photos from Flickr" do
    fill_in "card_original_text", with: "house"
    fill_in "card_translated_text", with: "дом"
    click_link 'Загрузить фото с Flickr'
    fill_in "card_photo_search_string", with: "house"

    VCR.use_cassette 'flickr', :match_requests_on => [:host] do
      click_button "Искать фото"
    end
    expect(page).to have_xpath "//li/a/img"
  end
end
