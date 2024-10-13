module Api
  # Counts the pets outside the zone per pet type and tracker type
  class PetsOutsideZoneCalculator
    HTTP_OK = 200
    HTTP_BAD_REQUEST = 404

    class << self
      def perform
        response = run_query
        process_response(response)
      rescue StandardError
        [ { errors: "Something went wrong" }, HTTP_BAD_REQUEST ]
      end

      private

      def run_query
        Pet.where(in_zone: false).group(:pet_type, :tracker_type).count
      end

      def process_response(response)
        json = {}

        response.each do |key, value|
          pet_type, tracker_type = key
          pet_type = pet_type.downcase.pluralize

          json[pet_type] = {} unless json.key?(pet_type)
          json[pet_type][tracker_type] = value
        end

        [ json, HTTP_OK ]
      end
    end
  end
end
