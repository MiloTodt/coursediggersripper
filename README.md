# coursediggersripper
Rips data for SFU courses from www.coursediggers.com 
This allows data such as fail rate, enrolment numbers, grade distribution.

# usage
"ruby rip.rb"
If you're just trying it out, lower the upper bound of the first loop or it will take a while to gather data.

To only view the result, please look in data.txt instead of running the script again for the sake of their bandwidth!

# structure

Raw .json saved to courses.txt
Pure data in data.txt
Format of data.txt:

Course name, Enrollment number, Average grade, Fail %

Can show grade distribution but is currently commented out awaiting better formating.



