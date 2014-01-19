require 'sinatra'
require 'open-uri'
require 'nokogiri'

get '/' do
	erb :index
end

get '/szukaj' do
	@keyword = params['keyword']
	url = "http://poradnia.pwn.pl/lista.php?szukaj=" + URI.encode(@keyword.encode("ISO-8859-2"))
	doc = Nokogiri.HTML(open(url))
	@result_sjp = doc.at_css('#listapytan').to_s.encode('UTF-8')
	url = "http://www.poradnia-jezykowa.uz.zgora.pl/wordpress/?s=przymiotnik&submit=Szukaj" + URI.encode(@keyword)
	doc = Nokogiri.HTML(open(url))
	@result_uz = doc.at_css('#content')
	erb :szukaj
end
 
