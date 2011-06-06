class WorkitemsController < ApplicationController
  # GET /workitems
  # GET /workitems.xml
  def index
    @workitems = Workitem.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @workitems }
    end
  end

  # GET /workitems/1
  # GET /workitems/1.xml
  def show
    @workitem = Workitem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @workitem }
    end
  end

  # GET /workitems/new
  # GET /workitems/new.xml
  def new
    @workitem = Workitem.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @workitem }
    end
  end

  # GET /workitems/1/edit
  def edit
    @workitem = Workitem.find(params[:id])
  end

  # POST /workitems
  # POST /workitems.xml
  def create
    @workitem = Workitem.new(params[:workitem])

    respond_to do |format|
      if @workitem.save
        format.html { redirect_to(@workitem, :notice => 'Workitem was successfully created.') }
        format.xml  { render :xml => @workitem, :status => :created, :location => @workitem }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @workitem.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /workitems/1
  # PUT /workitems/1.xml
  def update
    @workitem = Workitem.find(params[:id])

    respond_to do |format|
      if @workitem.update_attributes(params[:workitem])
        format.html { redirect_to(@workitem, :notice => 'Workitem was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @workitem.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /workitems/1
  # DELETE /workitems/1.xml
  def destroy
    @workitem = Workitem.find(params[:id])
    @workitem.destroy

    respond_to do |format|
      format.html { redirect_to(workitems_url) }
      format.xml  { head :ok }
    end
  end
end
