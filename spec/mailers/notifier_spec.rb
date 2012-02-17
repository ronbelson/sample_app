require "spec_helper"

describe Notifier do
  describe "send_test" do
    let(:mail) { Notifier.send_test }

    it "renders the headers" do
      mail.subject.should eq("hi ron")
      mail.to.should eq(["ronibelson@gmail.com"])
      mail.from.should eq(["ronbelson@gmail.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end
  
  describe "welcome" do
    let(:mail) { Notifier.welcome("ron","fofo@gmail.com") }

    it "renders the headers" do
      mail.subject.should eq("ron, welcome to sampleapp")
      mail.to.should eq(["fofo@gmail.com"])
      mail.from.should eq(["ronbelson@gmail.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
