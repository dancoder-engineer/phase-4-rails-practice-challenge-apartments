class ApartmentsController < ApplicationController

    rescue_from ActiveRecord::RecordNotFound, with: :unfound
    rescue_from ActiveRecord::RecordInvalid, with: :inv

    def index
        apartments = Apartment.all
        render json: apartments, status: 200
    end

    def destroy
        apartment = Apartment.find(params[:id])
        apartment.destroy
        head :no_content
    end

    def show
        apartment = Apartment.find(params[:id])
        render json: apartment, status: 200
    end

    def create
        apartment = Apartment.create!(permitted)
        render json: apartment, status: 200
    end

    def update
        apartment = Apartment.find(params[:id])
        apartment.update(permitted)
        render json: apartment, status: 200
    end

    private

    def inv(e)
        render json: {errors: e}, status: 422
    end

    def permitted
        params.permit(:number)
    end

    def unfound
        render json: {errors: ["Apartment not found."]}, status: 404
    end
    
end
