Fabricator(:user) do
    email { Faker::Internet.email }
    password_digest '$2a$04$ecHAsS1NbuEksUHYChCE1uWmJAuLvOfd1omy4XQzkm4XTBLOvgqfq'
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
end