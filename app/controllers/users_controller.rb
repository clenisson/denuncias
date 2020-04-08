class UsersController < ApplicationController
    before_action :authenticate_user!

    def me
        render json: current_user
    end

    def update
        begin
            current_user.update(update_params)
            render json: current_user
        rescue Exception => e 
            render json: {error: "Nenhum parâmetro permitido (name, password) informado para atualização "}, status: :bad_request
        end
    end

    private
    
    def update_params
        params.require(:user).permit(:password,:name)
    end
end
