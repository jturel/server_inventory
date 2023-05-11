require "test_helper"

module Api
  module V1
    class ServersControllerTest < ActionDispatch::IntegrationTest

      def test_update
        post api_v1_servers_path, params: {}

        assert_response :ok
      end

      def test_create
        post api_v1_servers_path, params: {}

        assert_response :ok
      end
    end
  end
end
