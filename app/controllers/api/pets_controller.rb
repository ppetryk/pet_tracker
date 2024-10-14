class Api::PetsController < ApplicationController
  before_action :find_record, only: [ :update, :show ]

  def create
    record = Pet.create(create_permitted_params)

    if record.valid?
      render json: record.attributes, status: :created
    else
      render json: { errors: record.errors.messages }, status: :bad_request
    end
  end

  def update
    success = @record.update(update_permitted_params)

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

  def create_permitted_params
    params.permit(:pet_type, :tracker_type, :owner_id, :in_zone, :lost_tracker)
  end

  def update_permitted_params
    params.permit(:tracker_type, :owner_id, :in_zone, :lost_tracker)
  end

  def find_record
    @record = Pet.find(params[:id])
  end
end
