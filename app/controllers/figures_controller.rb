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
  # Method to show a random combination of figures
  def open_pack
    @figures = Figure.all
    @pack = current_user.figures

    for a in 1..4
      @pack << @figures.shuffle.first
    end
    respond_to do |format|
      if current_user.save
        # format.html { redirect_to figures_url, notice: "You got #{p.first.name}, #{p.second.name}, #{p.third.name}, #{p.fourth.name}"}
        format.html { redirect_to figures_url, notice: "You opened you pack"}
        format.json { head :no_content }
      else
        format.html { redirect_to figures_url, notice: "Something went wrong"}
        format.json { head :no_content }
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
