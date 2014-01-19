require 'sinatra'
require 'open-uri'
require 'nokogiri'

get '/' do
	erb :index
end

get '/szukaj' do
	@keyword = params['keyword']

	url_sjp = "http://poradnia.pwn.pl/lista.php?szukaj=" + URI.encode(@keyword.encode("ISO-8859-2"))
	doc_sjp = Nokogiri.HTML(open(url_sjp))
	@result_sjp = doc_sjp.at_css('#listapytan').to_s.encode('UTF-8')

	url_uz = "http://www.poradnia-jezykowa.uz.zgora.pl/wordpress/?s=" + URI.encode(@keyword)
	doc_uz = Nokogiri.HTML(open(url_uz))
	@result_uz = doc_uz.at_css('#content')

	erb :szukaj
end
 
