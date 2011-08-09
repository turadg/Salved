class ElaborationsController < ApplicationController
  # GET /elaborations
  # GET /elaborations.json
  def index
    @elaborations = Elaboration.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @elaborations }
    end
  end

  # GET /elaborations/1
  # GET /elaborations/1.json
  def show
    @elaboration = Elaboration.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @elaboration }
    end
  end

  # GET /elaborations/new
  # GET /elaborations/new.json
  def new
    @elaboration = Elaboration.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @elaboration }
    end
  end

  # GET /elaborations/1/edit
  def edit
    @elaboration = Elaboration.find(params[:id])
  end

  # POST /elaborations
  # POST /elaborations.json
  def create
    @elaboration = Elaboration.new(params[:elaboration])

    respond_to do |format|
      if @elaboration.save
        format.html { redirect_to @elaboration, notice: 'Elaboration was successfully created.' }
        format.json { render json: @elaboration, status: :created, location: @elaboration }
      else
        format.html { render action: "new" }
        format.json { render json: @elaboration.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /elaborations/1
  # PUT /elaborations/1.json
  def update
    @elaboration = Elaboration.find(params[:id])

    respond_to do |format|
      if @elaboration.update_attributes(params[:elaboration])
        format.html { redirect_to @elaboration, notice: 'Elaboration was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @elaboration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /elaborations/1
  # DELETE /elaborations/1.json
  def destroy
    @elaboration = Elaboration.find(params[:id])
    @elaboration.destroy

    respond_to do |format|
      format.html { redirect_to elaborations_url }
      format.json { head :ok }
    end
  end
end
