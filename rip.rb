require 'open-uri'
for i in (1..10375) do
    url = 'http://www.coursediggers.com/data/' + i.to_s + '.json'
    begin
        source = open(url){|f|f.read}
    rescue OpenURI::HTTPError
        puts "skipped"
    else
    File.open("courses.txt", "a") do |f|
        f.write(source)
    end
    puts i
end
end




