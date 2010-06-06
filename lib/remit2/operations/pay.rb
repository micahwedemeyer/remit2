# Updated for API Version 2008-09-17
module Remit
  module Pay
    class Request < Remit::Request
      action :Pay
      parameter :caller_description
      parameter :caller_reference, :required => true
      parameter :charge_fee_to
      parameter :descriptor_policy, :type => Remit::RequestTypes::DescriptorPolicy
      parameter :marketplace_fixed_fee, :type => Remit::RequestTypes::Amount
      parameter :marketplace_variable_fee
      parameter :meta_data
      parameter :recipient_description
      parameter :recipient_reference
      parameter :recipient_token_id
      parameter :sender_description
      parameter :sender_reference
      parameter :sender_token_id, :required => true
      parameter :transaction_amount, :type => Remit::RequestTypes::Amount, :required => true
      parameter :transaction_date
      parameter :transaction_timeout_in_mins
    end
    
    class InnerResponse < Remit::BaseResponse
      parameter :transaction_id
      parameter :transaction_status
    end
    
    class Response < Remit::Response
      parameter :inner, :element => "PayResult", :type => InnerResponse
      inner_parameters :transaction_id, :transaction_status
    end

    def pay(request = Request.new)
      call(request, Response)
    end
  end
end
