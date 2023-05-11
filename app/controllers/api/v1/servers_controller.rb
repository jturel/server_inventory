module Api
  module V1
    class ServersController < ApplicationController
      HOST_PARAMS = [
        :hostname,
        :os,
        :ip
      ]

      def create
        host_params = params.permit(*HOST_PARAMS)
        server = Server.create!(host_params)

        render json: server
      end

      def update
        server = Server.find(params[:id])
        server.update!(params.permit(*HOST_PARAMS))

        render json: server
      end
    end
  end
end
