#include once "kiwi\kiwi.bi"
#include once "kiwi\time.bi" 

print "System's Time Zone:  " & KCalendar.getSystemTimeZoneTitle() 

Dim utcTime as DateTime = DateTime(System.currentTimeMillis())
print "UTC Time:            " & utcTime.toString()

Dim computerTime as DateTime = DateTime(System.currentTimeMillis(), KCalendar.getSystemTimeZoneOffsetHours())
print "System's Time:       " & computerTime.toString()

print KCalendar.getTimeInMillis()
print System.currentTimeMillis()
