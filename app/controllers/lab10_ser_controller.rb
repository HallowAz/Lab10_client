# frozen_string_literal: true

require 'open-uri'

# Server controller
class Lab10SerController < ApplicationController
  before_action :check_params, only: :show
  URL = 'http://localhost:3000/lab/show_xml?numb='
  def input; end

  def some_transformer
    send_file(
      "#{Rails.root}/public/some_transformer.xslt",
      type: 'text/xslt'
    )
  end

  def show
    @number = params[:numb]
    @format = params[:format]
    res_url = URL + params[:numb]
    respon = URI.open(res_url)
    case @format
    when 'xml'
      render xml: respon
    when 'html-server'
      render inline: Lab10SerHelper.print_res(respon)
    when 'html-client'
      render xml: Lab10SerHelper.insert_xslt_line(respon), format: 'xml'
    end
  end

  def check_params
    # logic for check for digits
    msg = if params[:numb] == '' || params[:numb].nil?
            'Nil class'
          elsif params[:numb].match?(/\D/)
            'Были введены не только цифры'
          end
    redirect_to root_path, notice: msg if msg
  end
end
