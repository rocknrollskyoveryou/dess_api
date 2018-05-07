describe 'DELETE /sessions' do
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

    it 'responds with 200' do
        header 'Content-Type', 'application/json'
        post '/sessions', JSON.generate({ user: { email: 'test@email.com', password: 'secret' }})
        token = JSON.parse(last_response.body).fetch('access_token')

        header 'Authorization', "Bearer #{token}"
        header 'Content-Type', 'application/json'
        delete '/sessions'
        last_response.must_be :ok?
    end
end