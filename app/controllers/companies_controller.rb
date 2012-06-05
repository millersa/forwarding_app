#coding: utf-8
class CompaniesController < ApplicationController
  before_filter :signed_in_user
load_and_authorize_resource
  # GET /companies
  # GET /companies.json
  def index
    #@companies = Company.paginate(page: params[:page])
    @companies = Company.where("user_id=?", current_user).page(params[:page]).per_page(10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @companies }
    end
  end

  # GET /companies/1
  # GET /companies/1.json
  # def show
   

  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.json { render json: @company }
  #   end
  # end

  # GET /companies/new
  # GET /companies/new.json
  def new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @company }
    end
  end

  # GET /companies/1/edit
  def edit
    
  end

  # POST /companies
  # POST /companies.json
  def create
    #@company = Company.new(params[:company])
     @company = current_user.companies.build(params[:company])
    #respond_to do |format|
      if @company.save
        #format.html { redirect_to @company, notice: 'Компания была успешно добавлена.' }
        #format.json { render json: @company, status: :created, location: @company }
        flash[:success] = 'Компания была успешно добавлена.'
        redirect_to companies_path
      else
        #format.html { render action: "new" }
        #format.json { render json: @company.errors, status: :unprocessable_entity }
      #end
      render 'new'
    end
  end

  # PUT /companies/1
  # PUT /companies/1.json
  def update
    @company = Company.find(params[:id])

    #respond_to do |format|
      if @company.update_attributes(params[:company])
       # format.html { redirect_to @company, notice: 'Компания была успешно обновлена.' }
        #format.json { head :no_content }
        flash[:success] = 'Компания была успешно обновлена.'
        redirect_to companies_path
      else
       # format.html { render action: "edit" }
        #format.json { render json: @company.errors, status: :unprocessable_entity }
      #end
      render 'edit'
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    authorize! :destroy, @user
    @company.destroy

    respond_to do |format|
      format.html { redirect_to companies_url }
      format.json { head :no_content }
    end
  end

  def updateShow
  @companiesJs = Company.where('id=?', "#{params[:id]}")
  render :partial => "update_show", :locals => { :companiesJs =>  @companiesJs }
end

end
