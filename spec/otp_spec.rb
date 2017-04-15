require "spec_helper"

describe Otp do
  describe '.encrypt' do
    example { expect(Otp.encrypt("foo",'bar').to_s).to eq("040e1d") }
    example { expect(Otp.encrypt("hello",'world').to_s).to eq("1f0a1e000b") }

    it do 
      expect{ Otp.encrypt("hello",'morewordsthanmessage') }.to raise_error "message/key different length"
    end

    describe 'should generate random key when no key given' do
      
      it do
        result = Otp.encrypt("hello") 
        expect(result.message.bytesize).to eq(5)
        expect(result.key.bytesize).to eq(5)
        expect(result.encrypted_message).to_not eq(nil)
      end
    end
  end
  describe '.generate_key' do
    it do
      expect(Otp.generate_key('hello').bytesize).to eq(5)
      expect(Otp.generate_key('hellohellohello').bytesize).to eq(15)
    end
  end

  describe 'decrypt' do
  end
end
