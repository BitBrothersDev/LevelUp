class MaterialContainersController < ApplicationController
  before_action :set_material_container, only: %i[ show edit update destroy ]

  # GET /material_containers or /material_containers.json
  def index
    @material_containers = MaterialContainer.all
  end

  # GET /material_containers/1 or /material_containers/1.json
  def show
  end

  # GET /material_containers/new
  def new
    @material_container = MaterialContainer.new
  end

  # GET /material_containers/1/edit
  def edit
  end

  # POST /material_containers or /material_containers.json
  def create
    @material_container = MaterialContainer.new(material_container_params)

    respond_to do |format|
      if @material_container.save
        format.html { redirect_to material_container_url(@material_container), notice: "Material container was successfully created." }
        format.json { render :show, status: :created, location: @material_container }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @material_container.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /material_containers/1 or /material_containers/1.json
  def update
    respond_to do |format|
      if @material_container.update(material_container_params)
        format.html { redirect_to material_container_url(@material_container), notice: "Material container was successfully updated." }
        format.json { render :show, status: :ok, location: @material_container }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @material_container.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /material_containers/1 or /material_containers/1.json
  def destroy
    @material_container.destroy

    respond_to do |format|
      format.html { redirect_to material_containers_url, notice: "Material container was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_material_container
      @material_container = MaterialContainer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def material_container_params
      params.require(:material_container).permit(:job_function_id, :level_id)
    end
end
