# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create!([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Cat.destroy_all
CatRentalRequest.destroy_all

cat1 = Cat.create!(birth_date: Faker::Date.birthday(1, 10), color: 'Blue', name: Faker::SiliconValley.character, sex: 'F', description: Faker::SiliconValley.quote )

cat2 = Cat.create!(birth_date: Faker::Date.birthday(1, 10), color: 'Blue', name: Faker::SiliconValley.character, sex: 'F', description: Faker::SiliconValley.quote )

cat3 = Cat.create!(birth_date: Faker::Date.birthday(1, 10), color: 'Blue', name: Faker::SiliconValley.character, sex: 'F', description: Faker::SiliconValley.quote )

cat4 = Cat.create!(birth_date: Faker::Date.birthday(1, 10), color: 'Blue', name: Faker::SiliconValley.character, sex: 'F', description: Faker::SiliconValley.quote )

cat5 = Cat.create!(birth_date: Faker::Date.birthday(1, 10), color: 'Blue', name: Faker::SiliconValley.character, sex: 'F', description: Faker::SiliconValley.quote )

req1 = CatRentalRequest.create!(cat_id: cat1.id, start_date: Faker::Date.between(3.days.ago, 1.day.ago), end_date: Faker::Date.between(1.day.ago, Date.today), status: 'PENDING')

req2 = CatRentalRequest.create!(cat_id: cat3.id, start_date: Faker::Date.between(5.days.ago, 3.days.ago), end_date: Faker::Date.between(3.days.ago, Date.today), status: 'APPROVED')

req3 = CatRentalRequest.create!(cat_id: cat3.id, start_date: Faker::Date.between(500.days.ago, 300.days.ago), end_date: Faker::Date.between(250.days.ago, 150.days.ago), status: 'APPROVED')
