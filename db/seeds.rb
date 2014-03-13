# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


require 'open-uri'
require 'active_record/fixtures'

User.create(
            :role => 'admin',
            :email => 'admin1@example.com',
            :password => '123123123',
            :password_confirmation => '123123123',
            
         )
User.create(
            :role => 'modernrator',
            :email => 'admin2@example.com',
            :password => '123123123',
            :password_confirmation => '123123123',
            
         )