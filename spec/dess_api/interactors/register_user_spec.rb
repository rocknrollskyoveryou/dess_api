require 'spec_helper'

describe RegisterUser do

    after do
        UserRepository.new.clear
    end

    it 'halts the flow if the email provided is already taken' do
        UserRepository.new.create(email: 'test1@example.com', password_digest: 'digest_password_231312312')
        result = RegisterUser.new({ email: 'test1@example.com', password: 'secret'}).call

        refute result.successful?
    end

    it 'encrypts the password and persists the user in db' do
        result = RegisterUser.new({ email: 'test2@example.com', password: 'secret'}).call
        user = result.user
        refute_nil UserRepository.new.find(user.id)
    end
end