#scrapes coursediggers
#this part will take a while (5 mins)
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
end #saves as JSON which is formatted down below



class Course
    def initialize(nameIn, gradeLetter,  failRate, grades)
	@name = nameIn
    @medianGradeLetter = gradeLetter
	@failRate = failRate
    @grades = grades
    end
    def saveInfo #saves to CSV text file, one entry per line
        #Format: Name, Enrollment, Average Grade, Fail Rate 
        gradeString = ""
        @grades.each{|grade|  
        # if (grade != nil) then 
        #     gradeString += "#{grade}, "
        #  end
        }
        outString = String.new()
        outString = "#{@name},  #{@grades.reduce(0, :+)}, #{@medianGradeLetter},   #{@failRate}\n"
         file = File.open("data.txt", "a") do |f|
             f.write(outString)
         end
    end
end


#formats .json to simple text file
c1 = Course.new("Macm 101", "A", "0.4", [0,1,1,7,14,24,27,39,28,20,4]) #example format
file = File.new("courses.txt", "r")

marks = Array.new(9)
 while (line = file.gets) != nil
    if(line.include?("name"))
        cName = line.split(": \"")[1].split("\",")[0]
    elsif(line.include?("\"data\":"))
        cData =  line.split("[[")[1].split("]]")[0].split(",")
        for i in (2..12)
            marks[i-2] = cData[i].to_i
        end
        c1 = Course.new(cName,cData[0],cData[1],marks)
        c1.saveInfo
    end
end
