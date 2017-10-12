# coursediggersripper
Rips data for SFU courses from www.coursediggers.com 
This allows data such as fail rate, enrolment numbers, grade distribution.

# usage
"ruby rip.rb"
If you're just trying it out, lower the upper bound of the first loop or it will take a while to gather data.

# structure

Raw .json saved to courses.txt
Pure data in data.txt
Format of data.txt:

Course name, Enrollment number, Average grade, Fail %



