require 'sinatra'
require 'open-uri'
require 'nokogiri'

get '/' do
	erb :index
end

get '/szukaj' do
	@keyword = params['keyword']

	@results = collection('http://poradnia.pwn.pl/lista.php?szukaj=', '#listapytan li', 'ISO-8859-2')
	@results = @results + collection('http://www.poradnia-jezykowa.uz.zgora.pl/wordpress/?s=', 'article')
	@results = @results + collection('http://www.wsjp.pl/index.php?szukaj=', '.wyszukiwanie_wyniki .wyszukiwanie_wyniki a')
	@results = @results + collection('http://sjp.pwn.pl/szukaj/', '#listahasel li')

	erb :szukaj
end
 
def collection(url_base, selector, encoding = "UTF-8")
	url = url_base + URI.encode(@keyword.encode(encoding))
	doc = Nokogiri.HTML(open(url))
	result = doc.css(selector)
end
