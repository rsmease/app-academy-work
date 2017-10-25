class CatRentalRequestController < ApplicationController


    def index
      @cat_rental_requests = CatRentalRequest.where(cat_id: params[:cat_id])
      render :index
    end

    def new
  
      render :new
    end

    def create
      cat_rental_request = CatRentalRequest.new(rental_request_params)
      if cat_rental_request.save
        redirect_to cats_url
      else
        render json: cat_rental_request.errors.full_messages
      end
    end

    def show
      @cat_rental_request = CatRentalRequest.find(params[:id])
      if @cat_rental_request
        render :show
      else
        @cat_rental_request.errors.full_messages
        redirect_to cats_url
      end
    end

    def edit
      @cat_rental_request = CatRentalRequest.find(params[:id])

      if @cat_rental_request
        render :edit
      else
        redirect_to cats_url
      end
    end

    def update
      cat_rental_request = CatRentalRequest.find(params[:id])

      if cat_rental_request.update(rental_request_params)
        redirect_to cat_url(cat_rental_request)
      else
        render json: cat_rental_request.errors.full_messages
        return
      end
    end

    private

    def rental_request_params
      params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date, :status)
    end


end
