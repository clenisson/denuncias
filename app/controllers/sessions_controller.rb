class SessionsController < Devise::SessionsController
  respond_to :json



  private
    def respond_with(resource, _opst = {})
        render json: resource
    end
    def respond_to_on_destroy
        head :ok
    end        
end