module Storages
  # Builder class which creates respective instance based on configuration
  class ReportStorage
    delegate :get, :set, to: :@report_storage

    # @params [String] destination Database table, bucket, key name or similar depending on database driver to insert and query data
    # @params [Hash] options Contains additional data or configuration to implement database driver specific class (optional)
    def initialize(destination, options = {})
      @report_storage =
        if configured_storage == "redis"
          Redis::ReportStorage.new(destination, options)
        else
          raise StandardError, "Unrecognized report storage"
        end
    end

    protected

    def configured_storage
      @configured_storage ||= Rails.configuration.storages.report_storage
    end
  end
end
