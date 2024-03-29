class MicropostsController < ApplicationController
  before_action :set_micropost, only: [:show, :edit, :update, :destroy]

  # GET /microposts
  # GET /microposts.json
  def index
    if (params[:user_id])
      @user = User.find(params[:user_id])
      @microposts = @user.microposts
    else
      @microposts = Micropost.all
    end
  end

  # GET /microposts/1
  # GET /microposts/1.json
  def show
  end

  # GET /microposts/new
  def new
    @micropost = Micropost.new
  end

  # GET /microposts/1/edit
  def edit
  end

  # POST /microposts
  # POST /microposts.json
  def create
    @micropost = Micropost.new(micropost_params)

    respond_to do |format|
      if ((User.exists?(@micropost.user_id)) && (@micropost.save))
        format.html { redirect_to @micropost, notice: 'Micropost was successfully created.' }
        format.json { render action: 'show', status: :created, location: @micropost }
      else
        format.html { 
          flash.now[:notice] = 'Invalid User Id.'
          render action: 'new'
        }
        format.json { render json: @micropost.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /microposts/1
  # PATCH/PUT /microposts/1.json
  def update
    respond_to do |format|
      if ((User.exists?(params[:micropost][:user_id])) && (@micropost.update(micropost_params)))
        format.html { redirect_to @micropost, notice: 'Micropost was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { 
          flash.now[:notice] = 'Invalid User Id.'
          render action: 'edit'
         }
        format.json { render json: @micropost.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /microposts/1
  # DELETE /microposts/1.json
  def destroy
    @micropost.destroy
    respond_to do |format|
      format.html { redirect_to microposts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_micropost
      @micropost = Micropost.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def micropost_params
      params.require(:micropost).permit(:content, :user_id)
    end
end
