require "net/https"
require "json"
require "cgi"

require "smartfile/client/error"
require "smartfile/client/response"

module SmartFile
  class Client

    CONTENT_TYPE = 'application/json'
    HOST = "https://app.smartfile.com"
    BASE_PATH = "/api/v2"
    PORT = 80

    METHODS = {
      :get    => Net::HTTP::Get,
      :post   => Net::HTTP::Post,
      :put    => Net::HTTP::Put,
      :delete => Net::HTTP::Delete
    }

    attr_accessor :api_key, :password
    attr_accessor :response, :json_response

    def initialize(api_key = ENV['SMARTFILE_API_KEY'], password = ENV['SMARTFILE_API_PASSWORD'])
      @api_key = api_key
      @password = password
    end

    # valid formats - [json] [json-p] [json-t] [html] [xhtml] [txt] [xml]
    def setup(endpoint, format = "json")
      case endpoint
        when :path_info
          @service_path = "/ping/?format=#{format}"
        when :path_data
          @service_path = "/whoami/?format=#{format}"
        when :session
          @service_path = "/session/?format=#{format}"
        when :ping
          @service_path = "/ping/?format=#{format}"
        when :whoami
          @service_path = "/whoami/?format=#{format}"
        when :session
          @service_path = "/session/?format=#{format}"  
      end
    end

    def ping
      response = post '/ping?format=json', {}
    end


    private

      METHODS.each do |method, _|
        define_method(method) do |path, params = {}, options = {}|
          request method, path, options.merge(params: params)
        end
      end

      def request(method, path, options)

        if params = options[:params] and !params.empty?
          q = params.map { |k, v| "#{CGI.escape(k.to_s)}=#{CGI.escape(v.to_s)}" }
          path += "&#{q.join('&')}"
        end

        req = METHODS[method].new(BASE_PATH + path, 'Accept' => CONTENT_TYPE)
        req.basic_auth(@api_key, @password)

        if options.key?(:body)
          req['Content-Type'] = CONTENT_TYPE
          req.body = options[:body] ? JSON.dump(options[:body]) : ''
        end

        http = Net::HTTP.new HOST, PORT
        res  = http.start { http.request(req) }

        case res
        when Net::HTTPSuccess
          return Response.new(res)
        else
          raise Error, res
        end
      end

  end#Class
end#Module