class SpicesController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def index
        render json: Spice.all
    end

    def create
        spice = Spice.create(spices_params)
        render json: spice, status: :created
    end

    def update
        spice = find_spice
        spice.update(spices_params)
        render json: spice
    end

    def destroy
        spice = find_spice
        spice.destroy
        head :no_content
    end

    private

    def spices_params
        params.permit(:title, :image, :description, :notes, :rating)
    end

    def find_spice
        Spice.find_by(params[:id])
    end

    def render_not_found_response
        render json: { error: 'No spice found' }, sratus: 404
    end

end
