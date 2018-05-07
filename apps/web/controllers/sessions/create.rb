module Web
    module Controllers
        module Sessions
            class Create
                include Web::Action
                include Authentication::Skip

                accept :json
                content_type :json
                
                params do
                    required(:user).schema do
                        required(:email).filled(:str?, format?: /@/)
                        required(:password).filled(:str?)
                    end
                end
                
                def call(params)
                    halt 422 unless params.valid?
                    login
                end
                
                def login
                    user = UserRepository.new.by_email(params.get(:user, :email))

                    halt 401 unless user
                    halt 403 unless valid_password?(user.password_digest)
                    
                    options = { iss: 'http://localhost/', user_id: user.id }
                    token = ::JwtIssuer.encode(options)
                    self.status = 201
                    self.body = { access_token: token, user: user }.to_json
                end
                
                private

                def valid_password?(password_digest)
                    Password.new(password_digest) == params.get(:user, :password)
                end
            end
        end
    end
end