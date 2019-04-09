# frozen_string_literal: true

class PlacementsController < ApplicationController

#     before_action :authenticate_user!
#     require 'roo'
    
#     def new
#         @placement = Placement.new
#         @licensees = Licensee.all
#         @services = Service.all
#     end
    
#     def create
#         Placement.create(
#             name: params[:placement][:name],
#             licensee_id: params[:placement][:licensee_id],
#             address: params[:placement][:address],
#             city: params[:placement][:city],
#             state: params[:placement][:state],
#             zip: params[:placement][:zip],
#             county: params[:placement][:county],
#             phone: params[:placement][:phone],
#             gender: params[:placement][:gender],
#             beds: params[:placement][:beds],
#         )
#         redirect_to placements_path
#     end
    
#     # licensee_id: params[::placement][:licensee_id]
#     # service_id: params[:placement][:service_id],    
    
#     def index
#         # search = "%#{params[:search]}%"
#         # @placements = Placement.where("name LIKE ? OR county LIKE ?" , search, search)

#         @q = Placement.ransack(params[:q])
#         @placements = @q.result(distinct: true)

#         respond_to do |format|
#             format.xlsx {
#                 response.headers[
#                 'Content-Disposition'
#                 ] = "attachment; filename=placements.xlsx"
#             }
#             format.html { render :index }
#         end
#     end
    
#     def show
#         @placement = Placement.find(params[:id])
#         @licensee = Licensee.find(@placement.licensee_id)
#         @comment = Comment.new(placement_id:@placement.id)
#         @comments = @placement.comments.collect
#     end

  before_action :authenticate_user!
  before_action :authorize_admin, only: %i(new edit)

  require 'roo'

  def new
    @placement = Placement.new
    @licensees = Licensee.all
    @services = Service.all
  end

  def create
    Placement.create(placement_params)
    redirect_to admins_path
  end

  # licensee_id: params[::placement][:licensee_id]
  # service_id: params[:placement][:service_id],

  def index


    # search = "%#{params[:search]}%"
    # @placements = Placement.where('name LIKE ? OR county LIKE ?', search, search)
      
    @q = Placement.ransack(params[:q])
    @placements = @q.result(distinct: true)
      

    # @placements = Placement.all
    # search = "%#{params[:search]}%"
    # @placements_search = Placement.where('name LIKE ? OR county LIKE ?', search, search)
  end

  #def search
    #search = "%#{params[:search]}%"
    #@placements_search = Placement.where('name LIKE ? OR county LIKE ?', search, search)
    # respond_to do |format|
    #    format.xlsx {
    #        response.headers[
    #        'Content-Disposition'
    #        ] = "attachment; filename=placements.xlsx"
    #    }
    #    format.html { render :index }
    # end
    # @cart_placement = current_cart.cart_placements.new
    #@cart = Cart.new
  #end
  

    # @placements = Placement.all
    # search = "%#{params[:search]}%"
    # @placements_search = Placement.where('name LIKE ? OR county LIKE ?',
    #                                      search, search)



  def show
    @placement = Placement.find(params[:id])
    @licensee = Licensee.find(@placement.licensee_id)
    @comment = Comment.new(placement_id: @placement.id)
    @comments = @placement.comments.collect
  end

  def edit
    @placement = Placement.find(params[:id])
    @licensees = Licensee.all
  end

  def update
    @placement = Placement.find(params[:id])
    @placement.update!(placement_params)
    redirect_to placement_path(@placement)
  end

  def destroy
    @placement = Placement.find(params[:id])
    @placement.destroy
    redirect_to placements_path
  end


  def comment
    @comment = Comment.new
  end

  private

  def placement_params
    params.require(:placement).permit(:name, :address, :city, :state, :zip,
                                      :county, :phone, :licensee_id, :gender,
                                      :beds, :search)
  end
end
