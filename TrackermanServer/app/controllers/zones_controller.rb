class ZonesController < ApplicationController
  before_action :set_zone, only: [:show, :edit, :update, :destroy]

  # GET /zones
  # GET /zones.json
  def index
    @zones = Zone.all
    gon.zones = @zones
  end

  # GET /zones/1
  # GET /zones/1.json
  def show
  end

  # GET /zones/new
  def new
    # needed??
    @zones = Zone.all
    gon.zones = @zones

    @zone = Zone.new
    gon.zone = @zone
  end

  # GET /zones/1/edit
  def edit
  end

  # POST /zones
  # POST /zones.json
  def create
    @zone = Zone.new(zone_params)

    respond_to do |format|
      if @zone.save
        format.html { redirect_to @zone, notice: 'Zone was successfully created.' }
        format.json { render :show, status: :created, location: @zone }
      else
        format.html { render :new }
        format.json { render json: @zone.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /zones/1
  # PATCH/PUT /zones/1.json
  def update
    respond_to do |format|
      if @zone.update(zone_params)
        format.html { redirect_to edit_zone_path(@zone), notice: 'Zone was successfully updated.' }
        format.json { render :show, status: :ok, location: @zone }
      else
        format.html { render :edit }
        format.json { render json: @zone.errors, status: :unprocessable_entity }
      end
    end

	#redirect_to edit_zone_path(@zone)
  end

  # DELETE /zones/1
  # DELETE /zones/1.json
  def destroy
    @zone.destroy
    respond_to do |format|
      format.html { redirect_to zones_url, notice: 'Zone was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_zone
      @zone = Zone.find(params[:id])
      gon.zone = @zone

      #
      # TMP HACK!
      #
      @zones = Zone.all
      gon.zones = @zones
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def zone_params
      params.require(:zone).permit(:name, {:polygons_attributes => [
          :id, :lat_start, :lng_start, :lat_end, :lng_end, :_destroy ]})
    end
end

#
#def rundatum_params
#  params.require(:rundatum).permit(
#      :material, :company_id, :material_density, :feed_moisture, :date,
#      :building, :machine, :material_weight, :time_mins, :rate_lb_hr,
#      :mill_amps, :class_amps, :mill_liner,
#      :beater_plate_size, :mill_rpm, :class_rpm, :feeder_type,
#      :feeder_setting, :feeder_aug_diameter, :tlgs_set, :air_pressure,
#      :temp_mill_out, :temp_prod_out, :temp_ambient,
#
#      { materials_attributes:
#            [:id, :name, :density, :msds_url, :moisture, :notes, :_destroy,
#              { particle_sizes_attributes: [:id, :screen, :percent_through, :percent_retained, :_destroy]
#              }
#            ]
#      }
#  )
#end