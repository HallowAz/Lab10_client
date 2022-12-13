require 'rails_helper'

RSpec.describe "Lab10Sers", type: :request do
  describe "GET /input" do
    it "returns http success" do
      get "/lab10_ser/input"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/lab10_ser/show"
      expect(response).to have_http_status(302)
    end
  end

  describe "logic" do
    context 'return different results for different values' do
      it 'for 100' do
        get lab10_ser_show_path, params: {numb: 100, format: 'html-server'}
        expect(response.body).to  match('<td>100</td>')
        expect(response.body).to  match('<td>101</td>')
      end

      it 'for 697' do
        get lab10_ser_show_path, params: {numb: 697, format: 'html-server'}
        expect(response.body).to  match('<td>697</td>')
        expect(response.body).to  match('<td>1493</td>')
        expect(response.body).to  match('<td>5434</td>')
        expect(response.body).to  match('<td>9779</td>')
      end  
    end

    context 'return different results for different values' do
      it 'for 100' do
        get lab10_ser_show_path, params: {numb: 100, format: 'html-client'}
        expect(response.body).to  match('<val>100</val>')
        expect(response.body).to  match('<val>101</val>')
      end

      it 'for 100' do
        get lab10_ser_show_path, params: {numb: 697, format: 'html-client'}
        expect(response.body).to  match('<val>697</val>')
        expect(response.body).to  match('<val>1493</val>')
        expect(response.body).to  match('<val>5434</val>')
        expect(response.body).to  match('<val>9779</val>')
      end
      
    end
  end

  describe 'Correct browser transfer' do
    it 'for value 1999' do
      file = File.open('public/test.xml', 'r')
      get lab10_ser_show_path, params: {numb: 1999, format: 'xml'}
      expect(response.body). to eq(file.read)
    end

    it 'xml_type' do
      get lab10_ser_show_path, params: {numb: 1999, format: 'xml'}
      expect(response.content_type).to eq("application/xml; charset=utf-8")
    end

    it 'html_type_server' do
      get lab10_ser_show_path, params: {numb: 1999, format: 'html-server'}
      expect(response.content_type).to eq("text/html; charset=utf-8")
    end

    it 'html_type_client' do
      get lab10_ser_show_path, params: {numb: 1999, format: 'html-client'}
      expect(response.content_type).to eq("application/xml; charset=utf-8")
    end
  end
end
