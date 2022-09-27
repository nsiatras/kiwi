#include once "kiwi\kiwi.bi"
#include once "kiwi\time.bi" 

' Print computer's clock timezone
Dim utcOffset as Integer = RealTimeClock.getUTCTimeZone()
print "System's Time Zone:     UTC " & iif(utcOffset>0 ,"+" & abs(utcOffset) , "-" & abs(utcOffset))
print ""

' Print UTC Time
Dim utcTime as DateTime = DateTime(System.currentTimeMillis())
print "UTC Time:               " & utcTime.toString()

' Create a calendar with computer's Time Zone and 
' print computer's date time
Dim systemCalendar as Calendar = Calendar(RealTimeClock.getUTCTimeZone())
Dim computerTime as DateTime = systemCalendar.getTime()
print "Computer's Time:        " & computerTime.toString()

' Create a calendar with Athens/Greece UTC+3 time zone
' and print date time of Athens/Greece
Dim athensGreeceCalendar as Calendar = Calendar(+3) '+3 UTC Time Zone
Dim timeInGreece as DateTime = athensGreeceCalendar.getTime()
print "Time in Athens/Greece:  " & timeInGreece.toString()

' Create a calendar with Berlin/Germany UTC+2 time zone
' and print date time of Berlin/Germany
Dim londonCalendar as Calendar = Calendar(+2) '+2 UTC Time Zone
Dim timeInLondon as DateTime = londonCalendar.getTime()
print "Time in Berlin/Germany: " & timeInLondon.toString()

