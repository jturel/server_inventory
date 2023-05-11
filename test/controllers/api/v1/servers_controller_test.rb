require "test_helper"

module Api
  module V1
    class ServersControllerTest < ActionDispatch::IntegrationTest

      def test_update
        existing = servers(:one)


        attrs = existing.attributes.
          slice(*Api::V1::ServersController::HOST_PARAMS).
          merge('hostname' => 'one-updated.example.com')

        put api_v1_server_path(existing), params: attrs

        assert_response :ok
        assert Server.find_by(attrs)
      end

      def test_create
        attrs = { hostname: 'new.example.com', os: 'Ubuntu 18.04', ip: '24.254.190.1' } 
        post api_v1_servers_path, params: attrs

        assert_response :ok
        assert Server.find_by(attrs)
      end
    end
  end
end
