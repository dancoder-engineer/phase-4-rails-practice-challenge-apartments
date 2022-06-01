class LeasesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :unfound

  #  def index
  #      leases = Lease.all
  #      render json: leases, status: 200
  #  end

    def destroy
        lease = Lease.find(params[:id])
        lease.destroy
        head :no_content
    end

    def create
        lease = Lease.create!(permitted)
        render json: lease, status: 200
    end

private

def permitted
    params.permit(:rent, :apartment_id, :tenant_id)
end

def unfound
    render json: { errors: ["Lease not found."]}, status: 404
end

end
