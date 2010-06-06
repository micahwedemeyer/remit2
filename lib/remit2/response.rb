module Remit
  class BaseResponse < Relax::Response
    def node_name(name, namespace=nil)
      super(name.to_s.gsub(/(^|_)(.)/) { $2.upcase }, namespace)
    end
  end
  
  class ResponseMetadata < BaseResponse
    parameter :request_id
  end

  class Response < BaseResponse
    parameter :response_metadata, :type => ResponseMetadata
    attr_accessor :errors

    def initialize(xml)
      super
      @errors = []
      
      if is?(:Response) && has?(:Errors)
        @errors = elements('Errors/Error').collect do |error|
          Error.new(error)
        end
      end
    end

    def successful?
      @errors.empty?
    end
    
    def request_id
      # If successful it's in the ResponseMetadata, if failure, it's in the base
      # response. Very irritating.
      if successful?
        response_metadata.request_id
      else
        elements('RequestId')[0].to_s
      end
    end

    def node_name(name, namespace=nil)
      super(name.to_s.split('/').collect{ |tag|
        tag.gsub(/(^|_)(.)/) { $2.upcase }
      }.join('/'), namespace)
    end
    
    # Easily exposes parameters that are buried in the InnerResponse
    def self.inner_parameters(*fields)
      fields.each do |inner_field_name|
        define_method(inner_field_name) { inner.send(inner_field_name) }
      end
    end
  end
end
