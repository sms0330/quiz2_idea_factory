# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Idea.delete_all
User.delete_all

10.times do
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    User.create(
        first_name: first_name,
        last_name: last_name,
        email: "#{first_name}.#{last_name}@example.com",
        password: 'password'
    )
end
users = User.all

100.times do
    created_at = Faker::Date.backward(days:365 * 5)
        i = Idea.create(
        title: Faker::Hacker.say_something_smart,
        description: Faker::ChuckNorris.fact,
        created_at: created_at,
        updated_at: created_at,
        user: users.sample
        )
end
ideas = Idea.all

puts Cowsay.say("Generated #{users.count} users", :tux)
puts Cowsay.say("Generated #{ideas.count} ideas", :koala)