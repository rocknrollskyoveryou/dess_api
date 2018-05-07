Fabricator(:user) do
    email { Faker::Internet.email }
    password_digest { BCrypt::Password.create('secret', cost: 1) }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
end