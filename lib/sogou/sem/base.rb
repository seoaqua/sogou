module Sogou
  module SEM
    class Base
      attr_accessor :username,:password,:token
      attr_accessor :debug

      def initialize(auth)
        classname = self.class.name.split('::').last
        @service_name =
          case classname
            when 'CampaignService'
              'CpcPlanService'
            when 'AccountService'
              'AccountService'
            when 'AdgroupService'
              'CpcGrpService'
            when 'KeywordService'
              'CpcService'
            when 'CreativeService'
              'CpcIdeaService'
            when 'ReportService'
              'ReportService'
            when 'DownloadService'
              'AccountDownloadService'
            when 'KRService'
              'KRService'
            end

        @port_name = @service_name
        @username = auth.username
        @password = auth.password
        @token = auth.token
        @client = Savon.new("http://api.agent.sogou.com:8080/sem/sms/v1/#{@service_name}?wsdl")

        # Savon.new(@base_uri+service_name+'?wsdl')
      end
      def method_missing(name, *args, &block)
        options,debug = args[0],args[1]
        options = {} if options.nil?
        name = name.to_s
        name_snake = name.snake_case
        # p name


        name_request_sym = (name +'Request').to_sym #if %w(getCampaignByCampaignId getAllCampaign addCampaign updateCampaign deleteCampaign).include?name
        # puts name_request_sym
        name_response_sym = (name+'Response').snake_case.to_sym
        operation = make_operation(name)
        operation.header = operation_header
        operation.body = {
          name_request_sym => options
        }
        ap operation.body if debug
        puts operation.build if debug
        response = operation.call
        ap response if debug
        # ap response.failures if debug
        if response.failures
          raise response.failures.to_s
        else
          Sogou::Response.new(response,name_response_sym)
        end
      end
      def operations
        @client.operations(@service_name,@port_name)
      end

      def make_operation(operation_name)
        @client.operation(@service_name,@port_name,operation_name)
      end

      def operation_header
       {
          :AuthHeader=>
          {
            :username=>@username,
            :password=>@password,
            :token=>@token
          }
        }
      end

      def example(operation,with_header=false)
        operation = make_operation(operation)
        if with_header
        {
          :example_header => operation.example_header,
          :example_body => operation.example_body
        }
        else
          operation.example_body
        end
      end

      # def invalid_options?(options,necessary_options)
      #   return true if necessary_options.any?{|necessary_option|!options.has_key?necessary_option}
      # end
    end
  end
end