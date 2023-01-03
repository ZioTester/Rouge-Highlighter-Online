class FormController < ApplicationController
  def index
    @home_active = "active"
    @home_tab_active = "show active"
    @preview_enabled = "disabled"
    @copy_enabled = "disabled"

  end

  def create
    @file_name = SecureRandom.uuid + ".txt"
    @codice = params[:codice]
    @lang = params[:lang]
    @theme = params[:theme]

    File.write("tmp/uploads/" + @file_name, @codice)
    redirect_to controller: 'form', action: "encode" , file_name: @file_name, lang: @lang, theme: @theme
  end

  def encode    

    @preview_active = "active"

    @file_name = params[:file_name]
    @lang = params[:lang]
    @theme = params[:theme]
    if File.exist?("tmp/uploads/" + @file_name)
      @source = File.read("tmp/uploads/" + @file_name)

      require 'rouge'
      formatter = Rouge::Formatters::HTMLInline.new(@theme)
      lexer = Rouge::Lexer.find(@lang)
      #lexer = Rouge::Lexers::Shell.new
      if @theme == 'base16.dark'
        @color = "#d0d0d0"
        @background = "#151515"
      elsif @theme == 'base16.light'
        @color = "#303030"
        @background = ""
      elsif @theme == 'base16.monokai.dark'
        @color = "#f8f8f2"
        @background = "#272822"
      elsif @theme == 'base16.monokai.light'
        @color = "#f8f8f2"
        @background = ""
      elsif @theme == 'base16.solarized.dark'
        @color = "#93a1a1"
        @background = "#002b36"
      elsif @theme == 'base16.solarized.light'
        @color = "#586e75"
        @background = ""
      elsif @theme == 'colorful'
        @color = "#bbbbbb"
        @background = "#000"
      elsif @theme == 'github'
        @color = "#212529"
        @background = "#f8f8f8"
      elsif @theme == 'gruvbox.light'
        @color = "#282828"
        @background = "#fbf1c7"
      elsif @theme == 'gruvbox.dark'
        @color = "#fbf1c7"
        @background = "#282828"
      elsif @theme == 'igorpro'
        @color = "#444444"
        @background = ""
      elsif @theme == 'molokai'
        @color = "#f8f8f2"
        @background = "#1b1d1e"
      elsif @theme == 'monokai'
        @color = "#f8f8f2"
        @background = "#49483e"
      elsif @theme == 'monokai.sublime'
        @color = "#ffffff"
        @background = ""
      elsif @theme == 'pastie'
        @color = "#212529"
        @background = ""
      elsif @theme == 'thankful_eyes'
        @color = "#faf6e4"
        @background = "#122b3b"
      elsif @theme == 'tulip'
        @color = "#FFFFFF"
        @background = "#231529"
      end
      @first_block = '<div style="overflow:auto;position: relative;margin-bottom: 1em;background: ' + @background + ';color: ' + @color + ';font-family: Monaco,Consolas,monospace;font-size: 1.0em;line-height: 1.8;border-radius:4px;"><pre>'
      @second_block = formatter.format(lexer.lex(@source))
      @final_block = '</pre></div>'
      File.delete("tmp/uploads/" + @file_name) if File.exist?("tmp/uploads/" + @file_name)
    else 
      redirect_to controller: 'form', action: "index"
    end
  end
end
 