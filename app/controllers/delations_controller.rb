class DelationsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_delation, only: [:show, :update, :destroy]

    def index 
        delations = Delation.order(id: :desc)

        if params[:search]
            if params[:search][:description]
                lower_desc = params[:search][:description].downcase
                delations = delations.where("LOWER(description) LIKE '%#{lower_desc}%'")
            end
        end

        delations = delations.page(params[:page] ? params[:page].to_i : 1).per(10)
        render json: {delations: delations, meta: pagination_meta(delations)}
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

    def pagination_meta(object)        
        {        
            current_page: object.current_page,        
            next_page: object.next_page,        
            prev_page: object.prev_page,        
            total_pages: object.total_pages,        
            total_count: object.total_count        
        }    
    end    
end
