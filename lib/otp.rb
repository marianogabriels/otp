require "otp/version"
require 'securerandom'

module Otp
  def self.encrypt(message,key=nil)
    key = generate_key(message) unless key
    Result.new(message,key)
  end

  def self.generate_key(message)
    SecureRandom.random_bytes(message.bytesize)
  end

  class Result
    attr_accessor :message,:key,:encrypted_message

    def initialize(message,key)
      raise "message/key different length" if message.length != key.length
      @message = message
      @key = key
      @encrypted_message = message.bytes.zip(key.bytes).map{|e| (e[0].to_i ^ e[1]).to_s(16).rjust(2,'0') }.join
    end

    def to_s
      @encrypted_message 
    end
  end
end
