describe 'POST /registration' do
    include Rack::Test::Methods

    def app
        Hanami.app
    end

    describe 'with valid params' do
        let(:params) { 
            { 
                user: {
                    email: Faker::Internet.email,
                    first_name: Faker::Name.first_name,
                    last_name: Faker::Name.last_name,
                    password: 'secret',
                    password_confirmation: 'secret' 
                }  
            }
        }

        before do
            post '/registration', params.to_json, { "CONTENT_TYPE" => "application/json" }
        end

        after do
            UserRepository.new.clear
        end

        it 'responds with 201' do 
            last_response.must_be :created?
        end

        it 'responds with user' do
            refute_nil JSON.parse(last_response.body).fetch('data').fetch('id')
        end    
    end    
    
    describe 'with invalid params' do
        it 'responds with 422' do
            post '/registration', '', { "CONTENT_TYPE" => "application/json" }
            last_response.must_be :unprocessable?
        end
    end
end