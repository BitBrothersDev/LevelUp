class JobFunctionsController < ApplicationController
  before_action :set_job_function, only: %i[ show edit update destroy ]

  # GET /job_functions or /job_functions.json
  def index
    @job_functions = JobFunction.all
  end

  # GET /job_functions/1 or /job_functions/1.json
  def show
  end

  # GET /job_functions/new
  def new
    @job_function = JobFunction.new
  end

  # GET /job_functions/1/edit
  def edit
  end

  # POST /job_functions or /job_functions.json
  def create
    @job_function = JobFunction.new(job_function_params)

    respond_to do |format|
      if @job_function.save
        format.html { redirect_to job_function_url(@job_function), notice: "Job function was successfully created." }
        format.json { render :show, status: :created, location: @job_function }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @job_function.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /job_functions/1 or /job_functions/1.json
  def update
    respond_to do |format|
      if @job_function.update(job_function_params)
        format.html { redirect_to job_function_url(@job_function), notice: "Job function was successfully updated." }
        format.json { render :show, status: :ok, location: @job_function }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @job_function.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /job_functions/1 or /job_functions/1.json
  def destroy
    @job_function.destroy

    respond_to do |format|
      format.html { redirect_to job_functions_url, notice: "Job function was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job_function
      @job_function = JobFunction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def job_function_params
      params.require(:job_function).permit(:title)
    end
end
