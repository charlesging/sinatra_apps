
require "sinatra"
require "sinatra/reloader" if development?
require "tilt/erubis"

before do 
  @contents = File.readlines('data/toc.txt')
end

not_found do
  redirect '/'
end

helpers do 
  def in_paragraphs(text)
    text.split("\n\n").each_with_index.map do |para, idx|
      "<p id=paragraph#{idx}>#{para}</p>"
    end.join
  end

  def highlight(term, paragraph)
    paragraph.gsub(term, "<strong>#{term}</strong>")
  end
end

get "/" do
  @title = "The Adventures of Sherlock Holmes"

  erb :home
end

get "/chapters/:number" do
  chap = params[:number].to_i
  chap_name = File.readlines('data/toc.txt')[chap - 1]

  not_found unless @contents.include?(chap_name)

  @chapter = File.read("data/chp#{chap}.txt")
  @title = "Chapter #{chap}: #{chap_name}"

  erb :chapter
end

def chapters_hash
  0.upto(@contents.length - 1).each_with_object({}) do |idx, hsh|
    chap_num = idx + 1
    content = File.read("data/chp#{chap_num}.txt")
    hsh[chap_num] = content
  end
end

def matching_chaps(query, chap_hash)
  results = []

  return results unless query

  chap_hash.each do |num, content|
    matches = {}
    content.split("\n\n").each_with_index do |paragraph, idx| 
      if paragraph.include?(query)
        matches[idx] = paragraph
      end
    end
    results << { chap_num: num, chap_name: @contents[num - 1], paragraphs: matches } if matches.any?
  end
  results
end

get "/search" do
  chap_hash = chapters_hash
  @matches = matching_chaps(params[:query], chap_hash)

  erb :search
end



