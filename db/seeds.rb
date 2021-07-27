# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Like.delete_all
Review.delete_all
Idea.delete_all
User.delete_all

PASSWORD='0414'
super_user=User.create(
    first_name: 'Joseph',
    last_name: 'Son',
    email: 'sms0330@gmail.com',
    password: PASSWORD,
    is_admin: true
)

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

        if i.persisted? 
            i.reviews = rand(0..15).times.map do
                Review.new(body: Faker::GreekPhilosophers.quote, user: users.sample)
            end
        end
        i.likers = users.shuffle.slice(0, rand(users.count))
end
ideas = Idea.all
reviews = Review.all
likes = Like.all

puts Cowsay.say("Generated #{users.count} users", :tux)
puts Cowsay.say("Generated #{ideas.count} ideas", :koala)
puts Cowsay.say("Generated #{reviews.count} reviews", :beavis)
puts Cowsay.say("Generated #{likes.count} likes", :cow)