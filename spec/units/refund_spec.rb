require File.dirname(__FILE__) + '/units_helper'

describe "the Refund API" do  
  describe "a successful response" do
    it_should_behave_like 'a successful response'

    before do
      doc = <<-XML
        <RefundResponse xmlns="http://fps.amazonaws.com/doc/2008-09-17/">
          <RefundResult>
            <TransactionId>1547A4MZV3EJVR7R1ETZBIGO6BLR386P827</TransactionId>
            <TransactionStatus>Pending</TransactionStatus>
          </RefundResult>
        <ResponseMetadata>
        <RequestId>9d5b22f7-5d3e-4910-93ae-e41b4c808206:0</RequestId>
        </ResponseMetadata>
      </RefundResponse>
      XML

      @response = Remit::Refund::Response.new(doc)
    end

    it "has a transaction id" do
      @response.transaction_id.should == '1547A4MZV3EJVR7R1ETZBIGO6BLR386P827'
    end

    it "has a transaction status" do
      @response.transaction_status.should == 'Pending'
    end
  end
end