require "rails_helper"
require "support/helpers/login_helper.rb"
include LoginHelper
require 'vcr'

feature "User loads words from remote url" do
  let!(:user) { create :user_with_one_block_and_one_card }
  before do
    visit root_path
    login "test@test.com", "12345", "Войти"
  end
  # scenario "they search photos in existing card" do
  #   visit edit_card_path user.cards.first
  #   click_link 'Загрузить фото с Flickr'
  #   fill_in "card_photo_search_string", with: "house"
  #   VCR.use_cassette 'flickr', match_requests_on: [:host] do
  #     click_button "Искать фото"
  #   end
  #   expect(page).to have_xpath "//li/a/img"
  # end

  # before { visit new_card_path }

  # scenario "they search photos in new card page" do
  #   click_link 'Загрузить фото с Flickr'
  #   fill_in "card_photo_search_string", with: "house"
  #   VCR.use_cassette 'flickr', match_requests_on: [:host] do
  #     click_button "Искать фото"
  #   end
  #   expect(page).to have_xpath "//li/a/img"
  # end

  scenario "they whant to load card" do
    visit remote_path
    fill_in "remote_url", with: "http://wordsteps.com/vocabulary/words/26708/20+%D1%81%D0%B0%D0%BC%D1%8B%D1%85+%D1%82%D1%80%D1%83%D0%B4%D0%BD%D1%8B%D1%85+%D1%81%D0%BB%D0%BE%D0%B2+%D0%B0%D0%BD%D0%B3%D0%BB%D0%B8%D0%B9%D1%81%D0%BA%D0%BE%D0%B3%D0%BE+%D1%8F%D0%B7%D1%8B%D0%BA%D0%B0"
    fill_in "row_selector", with: ".wrow"
    fill_in "original_selector", with: ".word"
    fill_in "translate_selector", with: ".trans"
    
    VCR.use_cassette 'remote_cards', match_requests_on: [:host] do
      click_button "Загрузить"
    end
    visit cards_path
    expect(page).to have_content "aluminium"
  end
end
