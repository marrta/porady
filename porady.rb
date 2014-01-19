require 'sinatra'
require 'open-uri'
require 'nokogiri'

get '/' do
	erb :index
end

get '/szukaj' do
	@keyword = params['keyword']

	url_poradnia = "http://poradnia.pwn.pl/lista.php?szukaj=" + URI.encode(@keyword.encode("ISO-8859-2"))
	doc_poradnia = Nokogiri.HTML(open(url_poradnia))
	@result_poradnia = doc_poradnia.at_css('#listapytan').to_s.encode('UTF-8')

	url_uz = "http://www.poradnia-jezykowa.uz.zgora.pl/wordpress/?s=" + URI.encode(@keyword.encode("UTF-8"))
	doc_uz = Nokogiri.HTML(open(url_uz))
	@result_uz = doc_uz.at_css('#content').to_s.encode("UTF-8")

	url_wsjp = "http://www.wsjp.pl/index.php?szukaj=" + URI.encode(@keyword.encode("UTF-8"))
	doc_wsjp = Nokogiri.HTML(open(url_wsjp))
	@result_wsjp = doc_wsjp.at_css('.wyszukiwanie_wyniki .wyszukiwanie_wyniki').to_s.encode("UTF-8")

	url_sjp = "http://sjp.pwn.pl/szukaj/" + URI.encode(@keyword.encode('UTF-8'))
	doc_sjp = Nokogiri.HTML(open(url_sjp))
	@result_sjp = doc_sjp.at_css('#tresc').to_s.encode('UTF-8')


	erb :szukaj
end
 
