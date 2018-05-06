require_relative '../services/password'

class User < Hanami::Entity
    def password
        Password.new(password_digest)
    end    
end
