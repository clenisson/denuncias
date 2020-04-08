class RegistrationsController < Devise::RegistrationsController
    respond_to :json

    def sign_up_params
        params.require(:user).permit(:name, :email, :password)
    end    
end