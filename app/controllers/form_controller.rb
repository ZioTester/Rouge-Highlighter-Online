class FormController < ApplicationController
  def index

  end

  def create
    @file_name = SecureRandom.uuid + ".txt"
    @codice = params[:codice]
    @lang = params[:lang]
    @theme = params[:theme]

    File.write("tmp/uploads/" + @file_name, @codice)
    redirect_to controller: 'form', action: "encode" , file_name: @file_name, lang: @lang, theme: @theme
  end

  def change
    @file_name = params[:file_name]
    @lang = params[:lang]
    @theme = params[:theme]
    redirect_to controller: 'form', action: "encode" , file_name: @file_name, lang: @lang, theme: @theme
  end

  def encode    
    @file_name = params[:file_name]
    @lang = params[:lang]
    @theme = params[:theme]
    if File.exist?("tmp/uploads/" + @file_name)
      source = File.read("tmp/uploads/" + @file_name)

      require 'rouge'
      formatter = Rouge::Formatters::HTMLInline.new(@theme)
      lexer = Rouge::Lexer.find(@lang)
      #lexer = Rouge::Lexers::Shell.new
      if @theme == 'base16.light'
        @first_block = '<div style="overflow:auto;position: relative;margin-bottom: 1em;color: #303030;font-family: Monaco,Consolas,monospace;font-size: 1.0em;line-height: 1.8;border-radius:4px;"><pre>'
      elsif @theme == 'base16.dark'
        @first_block = '<div style="overflow:auto;position: relative;margin-bottom: 1em;background: #151515;color: #d0d0d0;font-family: Monaco,Consolas,monospace;font-size: 1.0em;line-height: 1.8;border-radius:4px;"><pre>'
      elsif @theme == 'base16.monokai.light'
        @first_block = '<div style="overflow:auto;position: relative;margin-bottom: 1em;color: #f8f8f2;font-family: Monaco,Consolas,monospace;font-size: 1.0em;line-height: 1.8;border-radius:4px;"><pre>'
      elsif @theme == 'base16.monokai.dark'
        @first_block = '<div style="overflow:auto;position: relative;margin-bottom: 1em;background: #272822;color: #f8f8f2;font-family: Monaco,Consolas,monospace;font-size: 1.0em;line-height: 1.8;border-radius:4px;"><pre>'
      elsif @theme == 'base16.solarized.light'
        @first_block = '<div style="overflow:auto;position: relative;margin-bottom: 1em;color: #586e75;font-family: Monaco,Consolas,monospace;font-size: 1.0em;line-height: 1.8;border-radius:4px;"><pre>'
      elsif @theme == 'base16.solarized.dark'
        @first_block = '<div style="overflow:auto;position: relative;margin-bottom: 1em;background: #002b36;color: #93a1a1;font-family: Monaco,Consolas,monospace;font-size: 1.0em;line-height: 1.8;border-radius:4px;"><pre>'
      elsif @theme == 'colorful'
        @first_block = '<div style="overflow:auto;position: relative;margin-bottom: 1em;background: #000;color: #bbbbbb;font-family: Monaco,Consolas,monospace;font-size: 1.0em;line-height: 1.8;border-radius:4px;"><pre>'
      elsif @theme == 'github'
        @first_block = '<div style="overflow:auto;position: relative;margin-bottom: 1em;background: #f8f8f8;color: #212529;font-family: Monaco,Consolas,monospace;font-size: 1.0em;line-height: 1.8;border-radius:4px;"><pre>'
      elsif @theme == 'gruvbox.light'
        @first_block = '<div style="overflow:auto;position: relative;margin-bottom: 1em;background: #fbf1c7;color: #282828;font-family: Monaco,Consolas,monospace;font-size: 1.0em;line-height: 1.8;border-radius:4px;"><pre>'
      elsif @theme == 'gruvbox.dark'
        @first_block = '<div style="overflow:auto;position: relative;margin-bottom: 1em;background: #282828;color: #fbf1c7;font-family: Monaco,Consolas,monospace;font-size: 1.0em;line-height: 1.8;border-radius:4px;"><pre>'
      elsif @theme == 'igorpro'
        @first_block = '<div style="overflow:auto;position: relative;margin-bottom: 1em;color: #444444;font-family: Monaco,Consolas,monospace;font-size: 1.0em;line-height: 1.8;border-radius:4px;"><pre>'
      elsif @theme == 'molokai'
        @first_block = '<div style="overflow:auto;position: relative;margin-bottom: 1em;background: #1b1d1e;color: #f8f8f2;font-family: Monaco,Consolas,monospace;font-size: 1.0em;line-height: 1.8;border-radius:4px;"><pre>'
      elsif @theme == 'monokai'
        @first_block = '<div style="overflow:auto;position: relative;margin-bottom: 1em;background: #49483e;color: #f8f8f2;font-family: Monaco,Consolas,monospace;font-size: 1.0em;line-height: 1.8;border-radius:4px;"><pre>'
      elsif @theme == 'monokai.sublime'
        @first_block = '<div style="overflow:auto;position: relative;margin-bottom: 1em;color: #ffffff;font-family: Monaco,Consolas,monospace;font-size: 1.0em;line-height: 1.8;border-radius:4px;"><pre>'
      elsif @theme == 'pastie'
        @first_block = '<div style="overflow:auto;position: relative;margin-bottom: 1em;color: #212529;font-family: Monaco,Consolas,monospace;font-size: 1.0em;line-height: 1.8;border-radius:4px;"><pre>'
      elsif @theme == 'thankful_eyes'
        @first_block = '<div style="overflow:auto;position: relative;margin-bottom: 1em;background: #122b3b;color: #faf6e4;font-family: Monaco,Consolas,monospace;font-size: 1.0em;line-height: 1.8;border-radius:4px;"><pre>'
      elsif @theme == 'tulip'
        @first_block = '<div style="overflow:auto;position: relative;margin-bottom: 1em;background: #231529;color: #FFFFFF;font-family: Monaco,Consolas,monospace;font-size: 1.0em;line-height: 1.8;border-radius:4px;"><pre>'
      end
      @second_block = formatter.format(lexer.lex(source))
      @final_block = '</pre></div>'
      #File.delete("tmp/uploads/" + @file_name) if File.exist?(@file_name)
    else 
      redirect_to controller: 'form', action: "index"
    end
  end
end
 