$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'uri'
require 'openssl'
require 'net/https'
require 'date'
require 'base64'
require 'erb'

require 'rubygems'

gem 'relax', '0.0.7'
require 'relax'

require 'remit/common'
require 'remit/data_types'
require 'remit/error_codes'
require 'remit/ipn_request'
require 'remit/get_pipeline'
require 'remit/pipeline_response'
require 'remit/signature'

require 'remit/operations/cancel_subscription_and_refund'
require 'remit/operations/cancel_token'
require 'remit/operations/discard_results'
require 'remit/operations/fund_prepaid'
require 'remit/operations/get_account_activity'
require 'remit/operations/get_account_balance'
require 'remit/operations/get_all_credit_instruments'
require 'remit/operations/get_all_prepaid_instruments'
require 'remit/operations/get_debt_balance'
require 'remit/operations/get_outstanding_debt_balance'
require 'remit/operations/get_payment_instruction'
require 'remit/operations/get_prepaid_balance'
require 'remit/operations/get_results'
require 'remit/operations/get_token_by_caller'
require 'remit/operations/get_token_usage'
require 'remit/operations/get_tokens'
require 'remit/operations/get_total_prepaid_liability'
require 'remit/operations/get_transaction'
require 'remit/operations/install_payment_instruction'
require 'remit/operations/pay'
require 'remit/operations/refund'
require 'remit/operations/reserve'
require 'remit/operations/retry_transaction'
require 'remit/operations/settle'
require 'remit/operations/settle_debt'
require 'remit/operations/subscribe_for_caller_notification'
require 'remit/operations/unsubscribe_for_caller_notification'
require 'remit/operations/write_off_debt'

module Remit
  class API < Relax::Service
    include Signature
    
    include CancelSubscriptionAndRefund
    include CancelToken
    include DiscardResults
    include FundPrepaid
    include GetAccountActivity
    include GetAccountBalance
    include GetAllCreditInstruments
    include GetAllPrepaidInstruments
    include GetDebtBalance
    include GetOutstandingDebtBalance
    include GetPaymentInstruction
    include GetPipeline
    include GetPrepaidBalance
    include GetResults
    include GetTokenUsage
    include GetTokens
    include GetTokenByCaller
    include GetTotalPrepaidLiability
    include GetTransaction
    include InstallPaymentInstruction
    include Pay
    include Refund
    include Reserve
    include RetryTransaction
    include Settle
    include SettleDebt
    include SubscribeForCallerNotification
    include UnsubscribeForCallerNotification
    include WriteOffDebt

    API_ENDPOINT = 'https://fps.amazonaws.com/'
    API_SANDBOX_ENDPOINT = 'https://fps.sandbox.amazonaws.com/'
    PIPELINE_URL = 'https://authorize.payments.amazon.com/cobranded-ui/actions/start'
    PIPELINE_SANDBOX_URL = 'https://authorize.payments-sandbox.amazon.com/cobranded-ui/actions/start'
    API_VERSION = "2008-09-17"
    SIGNATURE_VERSION = 2
    SIGNATURE_METHOD = "HmacSHA256"

    attr_reader :access_key
    attr_reader :secret_key
    attr_reader :pipeline_url

    def initialize(access_key, secret_key, sandbox=false)
      @access_key = access_key
      @secret_key = secret_key
      @pipeline_url = sandbox ? PIPELINE_SANDBOX_URL : PIPELINE_URL

      super(sandbox ? API_SANDBOX_ENDPOINT : API_ENDPOINT)
    end

    def default_query
      Relax::Query.new({
        :AWSAccessKeyId => @access_key,
        :SignatureVersion => SIGNATURE_VERSION,
        :SignatureMethod => SIGNATURE_METHOD,
        :Version => API_VERSION,
        :Timestamp => Time.now.utc.strftime('%Y-%m-%dT%H:%M:%SZ')
      })
    end

    def query(request)
      query = super
      query[:Signature] = sign(@secret_key, @endpoint, "GET", query)
      query
    end
  end
end
