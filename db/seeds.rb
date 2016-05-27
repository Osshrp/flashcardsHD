# This file should contain all the record creation needed to seed the database
# with its default values.
# The data can then be loaded with the rake db:seed
# (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'nokogiri'
require 'open-uri'

doc = Nokogiri::HTML(open('https://www.learnathome.ru/blog/100-beautiful-words'))

user = User.create(email: 'test@test.ru',
                  password: '123',
                  password_confirmation: '123')

block = user.blocks.build(title: 'test')
block.save

doc.xpath('//table/tbody/tr').each do |row|
  original = row.search('td[2]')[0].content.downcase
  translated = row.search('td[4]')[0].content.downcase
  card = Card.new(original_text: original,
  	             translated_text: translated,
                 user_id: user.id, block_id: block.id)
  card.save
end

admin_user = User.create(email: 'admin@test.org',
                        password: 'admin',
                        password_confirmation: 'admin')
admin_user.add_role :admin
