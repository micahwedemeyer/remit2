# Updated for API Version 2008-09-17
# This operation is used by Amazon Simple Pay.
module Remit
  module CancelSubscriptionAndRefund
    class Request < Remit::Request
      action :CancelSubscriptionAndRefund
      parameter :caller_reference
      parameter :cancel_reason
      parameter :refund_amount, :type => Remit::RequestTypes::Amount
      parameter :subscription_id, :required => true
    end
    
    class InnerResponse < Remit::BaseResponse
      parameter :refund_transaction_id
    end
    
    class Response < Remit::Response
      parameter :inner, :element => "CancelSubscriptionAndRefundResult", :type => InnerResponse
      inner_parameters :refund_transaction_id
    end

    def cancel_subscription_and_refund(request = Request.new)
      call(request, Response)
    end
  end
end
