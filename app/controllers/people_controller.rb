class PeopleController < ApplicationController
  respond_to :html, :json, :xml
  
  # GET /people
  def index
    @people = Person.all
    respond_with(@people)
  end

  # GET /people/1
  def show
    @person = Person.find(params[:id])
    respond_with(@person)
  end

  # GET /people/new
  def new
    @person = Person.new
    respond_with(@person)
  end

  # GET /people/1/edit
  def edit
    @person = Person.find(params[:id])
    respond_with(@person)
  end

  # POST /people
  def create
    @person = Person.new(params[:person])
    if @person.save
      flash[:notice] = 'Person was successfully created.'
    end
    respond_with(@person)
  end

  # PUT /people/1
  def update
    @person = Person.find(params[:id])

    if @person.update_attributes(params[:person])
      flash[:notice] = 'Person was successfully updated.'
    end
    
    respond_with(@person)
  end

  # DELETE /people/1
  def destroy
    @person = Person.find(params[:id])
    @person.destroy

    respond_with(@person)
  end
end
