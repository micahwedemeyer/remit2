require File.dirname(__FILE__) + '/units_helper'

describe "the CancelSubscriptionAndRefund API" do  
  describe "a successful response" do
    it_should_behave_like 'a successful response'

    before do
      doc = <<-XML
        <CancelSubscriptionAndRefundResponse xmlns="http://fps.amazonaws.com/doc/2008-09-17/">
          <CancelSubscriptionAndRefundResult>
            <RefundTransactionId>154588GALWND3ML3EJ3NFDZ7SMQZHLMLJZP</RefundTransactionId>
          </CancelSubscriptionAndRefundResult>
          <ResponseMetadata>
            <RequestId>b5d6e665-6343-41db-bac7-17e251f353bf:0</RequestId>
          </ResponseMetadata>
        </CancelSubscriptionAndRefundResponse>
      XML

      @response = Remit::CancelSubscriptionAndRefund::Response.new(doc)
    end

    it "has a refund transaction id" do
      @response.refund_transaction_id.should == '154588GALWND3ML3EJ3NFDZ7SMQZHLMLJZP'
    end
  end
end
