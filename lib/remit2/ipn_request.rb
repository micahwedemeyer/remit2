module Remit
  # Encapsulates the logic for IPN request validation and attribute retrieval.
  #
  # This should probably be updated to support the VerifySignature function now provided.
  class IpnRequest
    # +params+ should be your controllers request parameters.
    # +url_endpoint+ should be the URL where you received the IPN
    # +remit_api+ should be a Remit::API object, initialized with your credentials
    def initialize(params, url_endpoint, remit_api)
      raise ArgumentError, "Expected the request params hash, received: #{params.inspect}" unless params.kind_of?(Hash)
      @params             = strip_keys_from(params, 'action', 'controller')
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
        :http_parameters => @params.collect {|k,v| "#{k}=#{v}"}.join("&")
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
    
    def strip_keys_from(params, *ignore_keys)
      parsed = params.dup
      ignore_keys.each { |key| parsed.delete(key) }
      parsed
    end
    private :strip_keys_from
    
  end
end
