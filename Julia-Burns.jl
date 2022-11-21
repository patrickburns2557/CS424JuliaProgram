#!/usr/bin/julia

##############################################
# Name:           Patrick Burns
# Class:          CS 424-01
# Instructor:     Dr. Harry S. Delugach
# Assignment:     Julia Program
# Date Written:   20 - ############################################################### November 2022
# Date Submitted: ####################################################################
# Due Date:       30 November 2022
##############################################


struct Student
    id
    name
end

struct Course
    crn
    courseName
end

struct Seat
    studentID
    courseCRN
end



bling = Student("A123", "bling bling boy")
math = Course("9999", "foundations of mathematics")

print(bling.id, "\n")
print(bling.name, "\n")
print(math.crn, "\n")
print(math.courseName, "\n")
print(typeof(math.crn))