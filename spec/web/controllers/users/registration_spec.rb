require 'spec_helper'
require_relative '../../../../apps/web/controllers/users/registration'

describe Web::Controllers::Users::Registration do
    include Rack::Test::Methods

    def app
        Hanami.app
    end

    it 'registers a new user' do 
        params = {"email" => "test5@example.com", "first_name" => "Tony", "last_name" => "Dif"}
        post '/registration', JSON.generate({ "user": params.merge({ "password" => "secret", "password_confirmation" => "secret" }) }), { "CONTENT_TYPE" => "application/json" }
        last_response.must_be :created?
        JSON.parse(last_response.body)['data']['attributes'].must_equal params
    end

    it 'refuse to register a new user' do
        post '/registration', '', { "CONTENT_TYPE" => "application/json" }
        last_response.must_be :unprocessable?
    end
end