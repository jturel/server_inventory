module Api
  module V1
    class ServersController < ApplicationController
      HOST_PARAMS = [
        'hostname',
        'os',
        'ip'
      ].freeze

      before_action :check_params

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

      def check_params
        # Ah! You're looking for the checking of the API params
        # The API currently only takes params that are mapped directly to model attributes
        # which means that there is a well-known set of errors that are automatically raised
        # when there are issues like failed model validations. See ApplicationController
        # for how those are handled generically
        #
        # If this API took any other parameters like pagination or search filter as input those 
        # would be well worth having controller-level checks for as those are not constructs native to Rails
        #
        # This is a best practice in my view!
      end

    end
  end
end
