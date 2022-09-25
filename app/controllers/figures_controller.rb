class FiguresController < ApplicationController
  before_action :authenticate_user!
  before_action :set_figure, only: %i[ show edit update destroy]

  # GET /figures or /figures.json
  def index
    @figures = Figure.all
  end

  # GET /figures/1 or /figures/1.json
  def show
  end

  # GET /figures/new
  def new
    @figure = Figure.new
  end

  # GET /figures/1/edit
  def edit
  end

  # POST /figures or /figures.json
  def create
    @figure = Figure.new(figure_params)

    respond_to do |format|
      if @figure.save
        format.html { redirect_to figure_url(@figure), notice: "Figure was successfully created." }
        format.json { render :show, status: :created, location: @figure }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @figure.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /figures/1 or /figures/1.json
  def update
    respond_to do |format|
      if @figure.update(figure_params)
        format.html { redirect_to figure_url(@figure), notice: "Figure was successfully updated." }
        format.json { render :show, status: :ok, location: @figure }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @figure.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /figures/1 or /figures/1.json
  def destroy
    @figure.destroy

    respond_to do |format|
      format.html { redirect_to figures_url, notice: "Figure was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  # Open Pack /open_pack
  def open_pack
    if current_user.enough_pack && current_user.can_open
      respond_to do |format|
        format.html { redirect_to figures_url, notice: "You got #{Figure.pack_open(current_user)}"}
      end
    else
      respond_to do |format|
        format.html { redirect_to figures_url, notice: "You dont have enough packs! / You reached the daily opening limit!"}
      end
    end
  end

  def get_free_pack
    if current_user.free_pack
      respond_to do |format|
        format.html { redirect_to figures_url, notice: "You got a new pack!" }
      end
    else
      respond_to do |format|
        format.html { redirect_to figures_url, notice: "You already claimed your daily pack, come back tomorrow!"}
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_figure
      @figure = Figure.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def figure_params
      params.require(:figure).permit(:name, :rarity, :description, :picture, :code)
    end
end
