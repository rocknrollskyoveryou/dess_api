# TODO: return a valuable error message when user registration fails
module Web
    module Controllers
        module Users
            class Registration
                include Web::Action
                include JSONAPI::Hanami::Action
                include Authentication::Skip
        
                
                accept :json
                content_type :json
        
                params do
                    required(:user).schema do
                        required(:email).filled(:str?, format?: /@/)
                        required(:first_name).filled(:str?)
                        required(:last_name).filled(:str?)
                        required(:password).filled(:str?).confirmation
                    end
                end
          
                def initialize(interactor: RegisterUser)
                    @interactor = interactor
                end
          
                def call(params)
                    halt 422 unless params.valid?
            
                    result = @interactor.new(params.get(:user)).call
                    if result.successful?
                        self.data = result.user
                        self.fields = { user: [:email, :first_name, :last_name] }
                        self.status = 201
                    else
                        halt 422
                    end
                end
            end
        end
    end
end