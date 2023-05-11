module Api
  module V1
    class ServersController < ApplicationController
      HOST_PARAMS = [
        :hostname,
        :os,
        :ip
      ]

      before_action :check_empty_params

      def create
        server = Server.create!(host_params)

        render json: server
      end

      def update
        server = Server.find(params[:id])
        server.update!(host_params)

        render json: server
      end

      private

      def host_params
        @host_params ||= params.permit(*HOST_PARAMS)
      end

      def check_empty_params
        raise ActionController::BadRequest, "Did you forget to send some parameters" if host_params.keys.empty?
      end
    end
  end
end
