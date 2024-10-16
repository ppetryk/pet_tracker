class Api::PetsController < ApplicationController
  before_action :find_record, only: [ :update, :show ]
  before_action :check_pet_type, only: [ :create ]

  def create
    record = Pet.create(permitted_params)

    if record.valid?
      render json: record.attributes, status: :created
    else
      render json: { errors: record.errors.messages }, status: :bad_request
    end
  end

  def update
    success = @record.update(permitted_params)

    if success
      render json: @record.attributes, status: :ok
    else
      render json: { errors: @record.errors.messages }, status: :bad_request
    end
  end

  def show
    render json: @record.attributes, status: :ok
  end

  def not_in_zone
    response, status = Api::PetsOutsideZoneCalculator.perform

    if status == 200
      Storages::Redis::ReportStorage.new("pets-outside-zone-count", timestamp: true).set(response)
    end

    render json: response, status: status
  end

  protected

  def permitted_params
    params.require(:pet).permit(:pet_type, :tracker_type, :owner_id, :in_zone, :lost_tracker)
  end

  def find_record
    @record = Pet.find(params[:id])
  end

  def check_pet_type
    unless Pet::PET_TYPES.include? permitted_params[:pet_type]
      render json: { errors: { pet_type: "Attribute not supported" } }, status: :bad_request
    end
  end
end
