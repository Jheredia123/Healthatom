class DemonSlayersController < ApplicationController
  before_action :set_demon_slayer, only: %i[ show edit update destroy ]

  # GET /demon_slayers or /demon_slayers.json
  def index
    @demon_slayers = DemonSlayer.unscoped.all
  end

  # GET /demon_slayers/1 or /demon_slayers/1.json
  def show
  end

  # GET /demon_slayers/new
  def new
    @demon_slayer = DemonSlayer.new
  end

  # GET /demon_slayers/1/edit
  def edit
  end

  # POST /demon_slayers or /demon_slayers.json
  def create
    @demon_slayer = DemonSlayer.new(demon_slayer_params)

    respond_to do |format|
      if @demon_slayer.save
        format.html { redirect_to @demon_slayer, notice: "Demon slayer was successfully created." }
        format.json { render :show, status: :created, location: @demon_slayer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @demon_slayer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /demon_slayers/1 or /demon_slayers/1.json
  def update
    respond_to do |format|
      if @demon_slayer.update(demon_slayer_params)
        format.html { redirect_to @demon_slayer, notice: "Demon slayer was successfully updated." }
        format.json { render :show, status: :ok, location: @demon_slayer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @demon_slayer.errors, status: :unprocessable_entity }
      end
    end
  end

  def export
    @demon_slayers = DemonSlayer.where(id: params[:ids]).presence || DemonSlayer.all
    json_data = @demon_slayers.map do |demon_slayer|
      {
        registro: demon_slayer.id,
        nombre: demon_slayer.name,
        kanji: demon_slayer.kanji,
        significado: demon_slayer.kanji_meaning,
        nivel_de_fuerza: demon_slayer.power
      }
    end.to_json

    send_data json_data,
      filename: "demon_slayers_export_#{Time.now.strftime('%Y%m%d%H%M%S')}.json",
      type: "application/json; charset=utf-8; header=present",
      disposition: 'attachment'

  end

  # DELETE /demon_slayers/1 or /demon_slayers/1.json
  def destroy
    @demon_slayer.update!(deleted_at: Time.now)

    respond_to do |format|
      format.html { redirect_to demon_slayers_path, status: :see_other, notice: "Demon slayer was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_demon_slayer
      @demon_slayer = DemonSlayer.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def demon_slayer_params
      params.expect(demon_slayer: [ :name, :kanji, :kanji_meaning, :power ])
    end
end
