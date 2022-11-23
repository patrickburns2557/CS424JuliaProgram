#!/usr/bin/julia

##############################################
# Name:           Patrick Burns
# Class:          CS 424-01
# Instructor:     Dr. Harry S. Delugach
# Assignment:     Julia Program
# Date Written:   20 - 22 November 2022
# Date Submitted: 22 November 2022
# Due Date:       30 November 2022
##############################################


struct Student
    id
    name
end
getName(s::Student) = s.name
getID(s::Student) = s.id

struct Course
    crn
    courseName
end
getCourseName(c::Course) = c.courseName
getCRN(c::Course) = c.crn

struct Seat
    studentID
    courseCRN
end
getStudentID(s::Seat) = s.studentID
getCourseCRN(s::Seat) = s.courseCRN


#Function splits the input line into 2 pieces at the first occurence of a space
#and then gets rid of all leading and trailing whitespace and converts all
#remaining whitespace into a single space.
#RETURN: a 2 element array containing the 2 split pieces
function splitLines(inputLine::String)
    splitInput = split(inputLine, " ", limit=2)
    splitInput[1] = strip(splitInput[1])
    splitInput[1] = replace(splitInput[1], r"\s+" => " ")
    splitInput[2] = strip(splitInput[2])
    splitInput[2] = replace(splitInput[2], r"\s+" => " ")

    splitInput
end

######################################################################

studentArray = Student[]
courseArray = Course[]
seatArray = Seat[]

println("======================================\nReading in Data.\n")

open("register.txt") do file
    global studentArray
    global courseArray
    global seatArray

    #Read in students, stopping at the empty line
    currentLine = readline(file)
    while currentLine != ""
        split = splitLines(currentLine)

        student = Student(split[1], split[2])
        push!(studentArray, student)

        currentLine = readline(file)
    end


    #Read in courses, stopping at the empty line
    currentLine = readline(file)
    while currentLine != ""
        split = splitLines(currentLine)
        
        course = Course(split[1], split[2])
        push!(courseArray, course)

        currentLine = readline(file)
    end


    #Read in seats, and stop when end of file reached
    currentLine = readline(file)
    while currentLine != ""
        split = splitLines(currentLine)
        

        #Check if the studetn with the given ID is enrolled
        foundS = any(getID(s) == split[1] for s in studentArray)
        if !foundS
            println("Student with ID \"", split[1], "\" is not enrolled.")
        end

        #Check if the course with hte given CRN exists or not
        foundC = any(getCRN(c) == split[2] for c in courseArray)
        if !foundC
            println("Course with CRN \"", split[2], "\" does not exist.")
        end

        #If either the student or the course doesn't exist, don't create the Seat object
        if !(foundS && foundC)
            currentLine = readline(file)
            continue
        end

        seat = Seat(split[1], split[2])
        push!(seatArray, seat)

        currentLine = readline(file)
    end
end

println("\nData read finished.\n======================================\n\n")


println("STUDENTS:\n======================================")

#Print out each student and the classes they're enrolled in
for student in studentArray
    courseCounter = 0
    println("Student: ", getName(student))
    println("Courses enrolled in:")

    for seat in seatArray #find which classes the student is enrolled in
        if getStudentID(seat) == getID(student)
            courseCounter += 1

            #Find which course name matches the found Course CRN in the seat
            course = courseArray[findfirst(c -> getCRN(c) == getCourseCRN(seat), courseArray)]

            println("[", courseCounter, "] ", getCourseName(course))
        end
    end
    println("\n")
end

println("\n")

println("COURSES:\n======================================")

#Print out each class and the students enrolled in it
for course in courseArray
    studentCounter = 0
    println("Course: ", getCourseName(course))
    println("Students enrolled:")

    for seat in seatArray #find which students are enrolled in the class
        if getCourseCRN(seat) == getCRN(course)
            studentCounter += 1

            #Find which studetn name matches the found Student ID in the seat
            student = studentArray[findfirst(s -> getID(s) == getStudentID(seat), studentArray)]

            println("[", studentCounter, "] ", getName(student))
        end
    end
    println("\n")
end