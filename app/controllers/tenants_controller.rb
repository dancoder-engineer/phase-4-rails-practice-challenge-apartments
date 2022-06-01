class TenantsController < ApplicationController

    rescue_from ActiveRecord::RecordNotFound, with: :unfound
    rescue_from ActiveRecord::RecordInvalid, with: :inv

    def index
        tenants = Tenant.all
        render json: tenants, status: 200
    end

    def destroy
        tenant = Tenant.find(params[:id])
        tenant.destroy
        head :no_content
    end

    def show
        tenant = Tenant.find(params[:id])
        render json: tenant, status: 200
    end

    def create
        tenant = Tenant.create!(permitted)
        render json: tenant, status: 200
    end

    def update
        tenant = Tenant.find(params[:id])
        tenant.update(permitted)
        render json: tenant, status: 200
    end

    
    private

    def inv(e)
        render json: {errors: e}, status: 422
    end

    def permitted
        params.permit(:name, :age)
    end

    def unfound
        render json: {errors: ["Tenant not found."]}, status: 404
    end

end
