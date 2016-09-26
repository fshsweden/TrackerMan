class TreasuresController < ApplicationController
  before_action :set_treasure, only: [:show, :edit, :update, :destroy]

  def broadcast (treasure, action)

	  puts "Sending Treasure Update!"
	  Pusher.trigger('treasure_channel',
	                 'treasure', {
		                object: treasure.to_json,
		                message: action
	                 })

  end

  # GET /treasures
  # GET /treasures.json
  def index
    @treasures = Treasure.all
	gon.treasures = Treasure.all
  end

  # GET /treasures/1
  # GET /treasures/1.json
  def show
  end

  # GET /treasures/new
  def new
    @treasure = Treasure.new
  end

  # GET /treasures/1/edit
  def edit
  end

  # POST /treasures
  # POST /treasures.json
  def create
    @treasure = Treasure.new(treasure_params)

    respond_to do |format|
      if @treasure.save
        format.html { redirect_to @treasure, notice: 'Treasure was successfully created.' }
        format.json { render :show, status: :created, location: @treasure }

		#broadcast @treasure, "created"
      else
        format.html { render :new }
        format.json { render json: @treasure.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /treasures/1
  # PATCH/PUT /treasures/1.json
  def update
    respond_to do |format|
      if @treasure.update(treasure_params)
        format.html { redirect_to @treasure, notice: 'Treasure was successfully updated.' }
        format.json { render :show, status: :ok, location: @treasure }

        #broadcast @treasure, "updated"
      else
        format.html { render :edit }
        format.json { render json: @treasure.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /treasures/1
  # DELETE /treasures/1.json
  def destroy
    @treasure.destroy
    respond_to do |format|
      format.html { redirect_to treasures_url, notice: 'Treasure was successfully destroyed.' }
      format.json { head :no_content }
      broadcast @treasure, "created"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_treasure
      @treasure = Treasure.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def treasure_params
      params.require(:treasure).permit(:name, :lat, :lng, :value, :start, :stop, :num_takers)
    end
end
