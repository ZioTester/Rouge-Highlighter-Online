class FormController < ApplicationController
  def index

  end

  def create
    @file_name = "tmp/" + SecureRandom.uuid + ".txt"
    @codice = params[:codice]
    @lang = params[:lang]

    File.write(@file_name, @codice)
    redirect_to controller: 'form', action: "encode" , file_name: @file_name, lang: @lang
  end

  def encode    
    @file_name = params[:file_name]
    @lang = params[:lang]
    if File.exist?(@file_name)
      source = File.read(@file_name)

      require 'rouge'
      formatter = Rouge::Formatters::HTMLInline.new("base16.dark")
      lexer = Rouge::Lexer.find(@lang)
      #lexer = Rouge::Lexers::Shell.new
      @first_block = '<div style="overflow:auto;position: relative;margin-bottom: 1em;background: #000;color: #b5b3aa;font-family: Monaco,Consolas,monospace;font-size: 1.0em;line-height: 1.8;border-radius:4px;"><pre>'
      @second_block = formatter.format(lexer.lex(source))
      @final_block = '</pre></div>'
      File.delete(@file_name) if File.exist?(@file_name)
    else 
      redirect_to controller: 'form', action: "index"
    end
  end
end
 