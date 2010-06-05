require 'remit2/common'

# Updated for API Version 2008-09-17
module Remit
  module Refund
    class Request < Remit::Request
      action :Refund
      parameter :caller_description
      parameter :caller_reference, :required => true
      parameter :refund_amount, :type => Remit::RequestTypes::Amount
      parameter :transaction_id, :required => true
      parameter :marketplace_refund_policy

      # The RefundAmount parameter has multiple components.  It is specified on the query string like
      # so: RefundAmount.Amount=XXX&RefundAmount.CurrencyCode=YYY
      def convert_complex_key(key, parameter)
        "#{convert_key(key).to_s}.#{convert_key(parameter).to_s}"
      end
    end

    class Response < Remit::Response
      parser :rexml
      parameter :refund_result, :type => RefundResult
    end

    def refund(request = Request.new)
      call(request, Response)
    end
  end
end
