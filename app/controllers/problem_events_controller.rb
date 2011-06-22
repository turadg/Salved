class ProblemEventsController < ApplicationController
  # GET /problem_events
  # GET /problem_events.json
  def index
    @problem_events = ProblemEvent.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @problem_events }
    end
  end

  # GET /problem_events/1
  # GET /problem_events/1.json
  def show
    @problem_event = ProblemEvent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @problem_event }
    end
  end

  # GET /problem_events/new
  # GET /problem_events/new.json
  def new
    @problem_event = ProblemEvent.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @problem_event }
    end
  end

  # GET /problem_events/1/edit
  def edit
    @problem_event = ProblemEvent.find(params[:id])
  end

  # POST /problem_events
  # POST /problem_events.json
  def create
    @problem_event = ProblemEvent.new(params[:problem_event])
    @problem_event.ip_address = request.remote_ip

    respond_to do |format|
      if @problem_event.save
        format.html { redirect_to @problem_event, notice: 'Problem event was successfully created.' }
        format.json { render json: @problem_event, status: :created, location: @problem_event }
      else
        format.html { render action: "new" }
        format.json { render json: @problem_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /problem_events/1
  # PUT /problem_events/1.json
  def update
    @problem_event = ProblemEvent.find(params[:id])

    respond_to do |format|
      if @problem_event.update_attributes(params[:problem_event])
        format.html { redirect_to @problem_event, notice: 'Problem event was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @problem_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /problem_events/1
  # DELETE /problem_events/1.json
  def destroy
    @problem_event = ProblemEvent.find(params[:id])
    @problem_event.destroy

    respond_to do |format|
      format.html { redirect_to problem_events_url }
      format.json { head :ok }
    end
  end
end
