module Web
    module Controllers
        module Authentication
            module Skip
                private
        
                def authenticate!
                end

                def current_user
                end
            end
            
            def self.included(base)
                base.class_eval do
                    before :authenticate!
                    expose :current_user
                end
            end
            
            def authenticate!
                halt 401 unless authenticated?
            end
            
            def current_user
                @current_user ||= authenticate_user
            end
            
            private

            def authenticated?
                !!current_user
            end
            
            def authenticate_user
                request.env['warden'].authenticate!
                user = request.env['warden'].user
                if user && !user.revoked
                    return @current_user = user
                end
            end
        end
    end
end