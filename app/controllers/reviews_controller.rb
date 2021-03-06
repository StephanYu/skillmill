class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_review, only: [:edit, :update, :destroy]
  #before_action :set_design, except: [:edit]
  #before_action :set_review, only: [:edit, :update, :destroy]
  before_action :check_user, only: [:edit, :update, :destroy]

  
  # GET /reviews/new
  def new
    @review = Review.new
  end

  # GET /reviews/1/edit
  def edit
    # binding.pry
    # @design = Design.find(params[:id])
    # @review = Review.where(design_id: @design.id)
    # @review = Review.find(design_id: @design.id)
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = Review.new(review_params)
    @design = Design.find(params[:design_id])
    # binding.pry
    # @review.user_id = current_user.id
    @review.user = current_user
    @review.design_id = @design.id

    respond_to do |format|
      if @review.save
        format.html { redirect_to design_path(@design), notice: 'Review was successfully created.' }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to design_path(@review.design), notice: 'Review was successfully updated.' }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to design_path(@review.design), notice: 'Review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_design
      # binding.pry
      @design = Design.find(params[:design_id])
      # @design = Design.find(params[:id])
    end

    def set_review
      
      # binding.pry
      # this is creating an array!!! How do I access the review I am trying to edit or delete. 
      @review = current_user.reviews.find(params[:id])
      #@design = @review.design
    end


    def check_user
      # binding.pry
      # Same issue here: How do I access the user of the selected review?
      unless (@review.user == current_user) || (current_user.admin?)
        redirect_to root_url, alert: "Sorry, this review belongs to someone else"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:rating, :comment)
    end
end
