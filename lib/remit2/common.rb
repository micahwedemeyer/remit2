require 'base64'
require 'erb'
require 'uri'

require 'rubygems'
require 'relax'

module Remit
  class Request < Relax::Request
    def self.action(name)
      parameter :action, :value => name
    end

    def convert_key(key)
      key.to_s.gsub(/(^|_)(.)/) { $2.upcase }.to_sym
    end
    protected :convert_key
  end

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
      else
        # Do they still have ServiceErrors in the API Version 2008-09-17????
        @status = text_value(element(:Status))
        @errors = elements('Errors/Error').collect do |error|
          ServiceError.new(error)
        end unless successful?
      end
    end

    def successful?
      @errors.empty?
    end
    
    def request_id
      response_metadata ? response_metadata.request_id : nil
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
