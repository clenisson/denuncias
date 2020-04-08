class UsersController < ApplicationController
    before_action :authenticate_user!, except: [:reset_password]

    def me
        render json: current_user
    end

    def update
        begin
            current_user.update(update_params)
            render json: current_user
        rescue Exception => e 
            render json: {error: "Nenhum parâmetro permitido (name, password) informado para atualização"}, status: :bad_request
        end
    end

    def reset_password
        begin 
            user = User.where(email: params[:user][:email]).first
            # send email
            new_password = SecureRandom.urlsafe_base64(8)
            user.update(password: new_password)
            ResetPasswordMailer.send_new_password(user, new_password).deliver_now
            
            render json: {success: "Uma nova senha foi enviada para o seu e-mail"}, status: :ok        
            
        rescue Exception => e 
            render json: {error: "Cadastro não encontrado"}, status: :not_found        
        end
    end

    private
    
    def update_params
        params.require(:user).permit(:password,:name)
    end

end
