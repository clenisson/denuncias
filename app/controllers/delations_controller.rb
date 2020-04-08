class DelationsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_delation, only: [:show, :update, :destroy]

    def index 
        render json: Delation.order(id: :desc)
    end

    def create
        params = delations_params.merge(user_id: current_user.id, status: "created")
        delation = Delation.create!(params)

        render json: delation, status: :created
    end

    def update
        permitted = params.permit(:status, :resolution)
        @delation.update!(permitted) if @delation.user == current_user

        render json: @delation, status: :ok
    end

    def destroy
        @delation.destroy! if @delation.user == current_user

        render json: {success: "Denúncia excluída"}, status: :ok
    end

    private
    def delations_params
        params.permit(:description, :status, :latitude, :longitude)
    end

    def set_delation
        @delation = Delation.find(params[:id])
    end
end
