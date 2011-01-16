module Remit
  # Encapsulates the logic for IPN request validation and attribute retrieval.
  #
  # This should probably be updated to support the VerifySignature function now provided.
  class IpnRequest
    
    # Handy helper for frameworks (like Rails) that use Rack
    # Just pass it the request object and it will infer the http parameters and URL endpoint
    # +request+ should be the Rack request
    # +remit_api+ should be a Remit::API object, initialized with your credentials
    def self.from_rack_request(request, remit_api)
      http_parameters = request.post? ? request.body.read : request.query_string
      url_endpoint = "#{request.protocol}#{request.host_with_port}#{request.path}"
      self.new(http_parameters, url_endpoint, remit_api)
    end
    
    # +http_parameters+ should be the HttpParameters string, as specified in the VerifySignature docs
    # +url_endpoint+ should be the UrlEndPoint string, as specificed in the VerifySignature docs
    # +remit_api+ should be a Remit::API object, initialized with your credentials
    def initialize(http_parameters, url_endpoint, remit_api)
      @http_parameters    = http_parameters
      
      # Build the params hash from the http_params
      @params = {}
      @http_parameters.split("&").each do |kv_pair|
        k,v = kv_pair.split("=")
        @params[k]=v
      end
      
      @url_endpoint       = url_endpoint
      @remit_api          = remit_api
    end
    
    def valid?
      resp = verify_signature
      resp.successful? && resp.verification_status == "Success"
    end
    
    def verify_signature
      req = Remit::VerifySignature::Request.new(
        :url_end_point => @url_endpoint,
        :http_parameters => @http_parameters
      )
      @remit_api.verify_signature(req)
    end

    def method_missing(method, *args) #:nodoc:
      if @params.has_key?(method.to_s)
        @params[method.to_s]
      else
        super(method, *args)
      end
    end
  end
end
