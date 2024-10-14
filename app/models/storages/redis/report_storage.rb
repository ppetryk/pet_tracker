module Storages
  module Redis
    # Implement read/write to Redis with report functionality
    class ReportStorage
      # @params [String] key Redis key name to query and write data
      # @params [Hash] options Contains additional configurations (Optional)
      def initialize(key, options = {})
        @options = options
        self.key = key
      end

      # Redis does not support nested hashes
      # So we need to convert the hash to JSON
      def set(val, key = nil)
        self.key = key if key
        client.set(@key, val.to_json)
      end

      # Redis does not support nested hashes
      # So we have to convert back the JSON to hash
      def get(key = nil)
        self.key = key if key
        str_json = client.get(@key)
        JSON.parse(str_json)
      end

      def key=(key)
        @key = timestamp_key(key)
      end

      protected

      def client
        @client ||= ::Redis.new
      end

      def timestamp_key(key)
        @options[:timestamp] ? "#{key}:#{Time.now.to_i}" : key
      end
    end
  end
end
