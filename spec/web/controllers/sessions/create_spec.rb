describe 'POST /sessions api' do
    include Rack::Test::Methods

    def app
        Hanami.app
    end

    let(:user) { Fabricate.build(:user, email: 'test@email.com') }

    before do
        UserRepository.new.create(user)
    end

    after do
        UserRepository.new.clear
    end

    describe 'with valid credentials' do

        before do
            post '/sessions', JSON.generate({ user: { email: 'test@email.com', password: 'secret' }}), { "CONTENT_TYPE" => "application/json" }
        end

        it 'responds with 201' do
            last_response.must_be :created?
        end

        it 'responds with auth_token' do
            refute_nil JSON.parse(last_response.body).fetch('access_token', nil)
        end
    end

    describe 'with invalid credentials' do

        before do
            post '/sessions', JSON.generate({ user: { email: 'wrong_email@email.com', password: 'abc' }}), { "CONTENT_TYPE" => "application/json" }
        end

        it 'responds with 401' do
            assert_equal 401, last_response.status
        end
    end
end