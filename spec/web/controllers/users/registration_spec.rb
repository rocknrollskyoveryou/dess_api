require 'spec_helper'
require_relative '../../../../apps/web/controllers/users/registration'

describe Web::Controllers::Users::Registration do
    include Rack::Test::Methods

    def app
        Hanami.app
    end

    it 'should register a new user' do 
        params = {"email" => "test5@example.com", "first_name" => "Tony", "last_name" => "Dif"}
        post '/registration', JSON.generate({ "user": params.merge({ "password" => "secret", "password_confirmation" => "secret" }) }), { "CONTENT_TYPE" => "application/json" }
        last_response.must_be :created?
        JSON.parse(last_response.body)['data']['attributes'].must_equal params
    end    
    # let(:action) { Web::Controllers::Users::Registration.new }
    

    # describe 'with invalid params' do
    #     it 'it returns 422' do
    #         response = action.call({})
    #         response[0].must_equal 422
    #     end

    #     it 'it returns 201' do
    #         response = action.call(params)
    #         body = JSON.parse(response[2][0])
    #         byebug
    #         response[0].must_equal 201
            
    #     end    
    # end
end