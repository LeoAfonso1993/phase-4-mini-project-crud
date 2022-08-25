class SpicesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    #GET /spices
    def index
        spices = Spice.all
        render json: spices
    end

    # POST /spices
    def create
        spice = Spice.create(spices_params)
        render json: spice, status: :created
    end

    #PATCH /spices/:id
    def update
        spice=find_spices
        spice.update(spices_params)
        render json: spice
    end

    #DELETE /spices/:id
    def destroy
        spice = find_spices
        spice.destroy
        render json: []
    end


private

    def spices_params
        params.permit(:title, :image, :description, :notes, :rating)
    end

    def render_not_found_response
        render json: { error: "Spice not found" }, status: :not_found
    end

    def find_spices
        Spice.find(params[:id])
    end

end
