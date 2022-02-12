# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin = User.create(email: Faker::Internet.email, password: '12345678', role: 'admin')
user = User.create(email: Faker::Internet.email, password: '12345678')
access_token = ApiAccessToken.create(user: user)

5.times { ProgramCategory.create(name: Faker::Educator.subject) }
5.times { Currency.create(name: Faker::Currency.code) }
5.times { ProgramType.create(name: Faker::Hobby.activity) }
10.times { Program.create(
  name: Faker::Educator.course_name,
  price: Random.rand(50..200),
  program_category_id: Random.rand(1..5),
  currency_id: Random.rand(1..5),
  program_type_id: Random.rand(1..5),
  url: Faker::Internet.url,
  status: 'active',
  description: Faker::Lorem.paragraph,
  validity_period: Random.rand(1..30)
) }

10.times { Program.create(
  name: Faker::Educator.course_name,
  price: Random.rand(50..200),
  program_category_id: Random.rand(1..5),
  currency_id: Random.rand(1..5),
  program_type_id: Random.rand(1..5),
  url: Faker::Internet.url,
  status: 'inactive',
  description: Faker::Lorem.paragraph,
  validity_period: Random.rand(1..30)
) }

for program_id in 1..10 do
  OrderCreator.new(user, program_id).send_order
end
