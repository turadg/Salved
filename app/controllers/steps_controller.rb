class StepsController < ApplicationController
  # GET /elaboration/1/steps
  # GET /elaboration/1/steps.json
  def index
    @steps = Elaboration.find(params[:elaboration_id]).steps.order(:index)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @steps }
    end
  end

  # GET /elaboration/1/steps/1
  # GET /elaboration/1/steps/1.json
  def show
    @step = Elaboration.find(params[:elaboration_id]).steps.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @step }
    end
  end

  # GET /elaboration/1/steps/new
  # GET /elaboration/1/steps/new.json
  def new
    @step = Elaboration.find(params[:elaboration_id]).steps.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @step }
    end
  end

  # GET /elaboration/1/steps/1/edit
  def edit
    @step = Elaboration.find(params[:elaboration_id]).steps.find(params[:id])
  end

  # POST /elaboration/1/steps
  # POST /elaboration/1/steps.json
  def create
    @step = Elaboration.find(params[:elaboration_id]).steps.build(params[:step])

    respond_to do |format|
      if @step.save
        format.html { redirect_to [@step.elaboration, @step], notice: 'Step was successfully created.' }
        format.json { render json: @step, status: :created, location: @step }
      else
        format.html { render action: "new" }
        format.json { render json: @step.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /elaboration/1/steps/1
  # PUT /elaboration/1/steps/1.json
  def update
    @step = Elaboration.find(params[:elaboration_id]).steps.find(params[:id])

    respond_to do |format|
      if @step.update_attributes(params[:step])
        format.html { redirect_to [@step.elaboration, @step], notice: 'Step was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @step.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /elaboration/1/steps/1
  # DELETE /elaboration/1/steps/1.json
  def destroy
    elaboration = Elaboration.find(params[:elaboration_id])
    @step = elaboration.steps.find(params[:id])
    @step.destroy

    respond_to do |format|
      format.html { redirect_to elaboration_steps_url(elaboration) }
      format.json { head :ok }
    end
  end
end
