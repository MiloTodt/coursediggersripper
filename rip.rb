# *************************************************************************
# Scrapes coursediggers.com .json files to allow statistics usage
#  
#
#  Milo Todt // www.github.com/MiloTodt // Milo@milotodt.com // [2017]
# *************************************************************************

out_file = File.new("data.txt", "w") if File.exist?("data.txt") == false
out_file.close
out_file = File.new("courses.txt", "w") if File.exist?("courses.txt") == false
out_file.close


require 'open-uri'
for i in (1..10375) do #This will take a while, about 5 minutes. If you're just trying the code out lower the upper bound to a few hundred
    url = 'http://www.coursediggers.com/data/' + i.to_s + '.json'
    begin
        source = open(url){|f|f.read}
    rescue OpenURI::HTTPError #404's salvage, not all numbers are taken.
        puts "skipped"
    else
    File.open("courses.txt", "a") do |f|
        f.write(source)
    end
    puts i
end
end #saves as JSON which is formatted down below

class Course
    def initialize(nameIn, gradeLetter,  failRate, grades) #used a class for additional control of future integration
	@name = nameIn
   	@medianGradeLetter = gradeLetter
	@failRate = failRate
   	@grades = grades
    end
    
    def saveInfo #saves to CSV text file, one entry per line
        #Format: Name, Enrollment, Average Grade, Fail Rate 

        #This is for if you want to output how many people recieved each grade.
        # gradeString = ""
        # @grades.each{|grade|  
        # # if (grade != nil) then 
        # #     gradeString += "#{grade}, "
        # #  end
        # } 
        if(@medianGradeLetter.length <= 4) #hackish fix for change of formating in json files for classes with multiple teachers
            outString = String.new()
            outString = "#{@name},  #{@grades.reduce(0, :+)}, #{@medianGradeLetter},   #{@failRate}\n"
            file = File.open("data.txt", "a") do |f|
                f.write(outString)
            end
        end
     end
end

#formats .json to simple text file
c1 = Course.new("Macm 101", "A", "0.4", [0,1,1,7,14,24,27,39,28,20,4]) #example format

file = File.new("data.txt", "r")
file = File.new("courses.txt", "r")
marks = Array.new(9)
 while (line = file.gets) != nil
    if(line.include?("name"))
        cName = line.split(": \"")[1].split("\",")[0] #name of course
    elsif(line.include?("\"data\":"))
        cData =  line.split("[[")[1].split("]]")[0].split(",") #all other info
        for i in (2..12)
            marks[i-2] = cData[i].to_i
        end
        c1 = Course.new(cName,cData[0],cData[1],marks)
        c1.saveInfo
    end
end
