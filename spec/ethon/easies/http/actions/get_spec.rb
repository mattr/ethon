require 'spec_helper'

describe Ethon::Easies::Http::Actions::Get do
  let(:easy) { Ethon::Easy.new }
  let(:url) { "http://localhost:3001/" }
  let(:params) { nil }
  let(:form) { nil }
  let(:get) { described_class.new(url, {:params => params, :body => form}) }

  describe "#setup" do
    before { get.setup(easy) }

    context "when nothing" do
      it "sets httpget" do
        easy.httpget.should be
      end

      it "sets url" do
        easy.url.should eq(url)
      end
    end

    context "when params" do
      let(:params) { {:a => "1&b=2"} }

      it "sets httpget" do
        easy.httpget.should be
      end

      it "attaches escaped to url" do
        easy.url.should eq("#{url}?a=1%26b%3D2")
      end

      context "when requesting" do
        before do
          easy.prepare
          easy.perform
        end

        it "is a get request" do
          easy.response_body.should include('"REQUEST_METHOD":"GET"')
        end

        it "requests parameterized url" do
          easy.effective_url.should eq("http://localhost:3001/?a=1%26b%3D2")
        end
      end
    end
  end
end