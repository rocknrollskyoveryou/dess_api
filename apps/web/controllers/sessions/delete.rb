module Web
    module Controllers
        module Sessions
            class Delete
                include Web::Action

                accept :json

                def call(params)
                    self.status = 200
                end
            end
        end
    end
end