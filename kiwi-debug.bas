#include once "kiwi\kiwi.bi"
#include once "kiwi\time.bi" 

Dim utcOffset as Integer = RealTimeClock.getUTCTimeZone()
print "System's Time Zone:  UTC " & iif(utcOffset>0 ,"+" & abs(utcOffset) , "-" & abs(utcOffset))

Dim utcTime as DateTime = DateTime(System.currentTimeMillis())
print "UTC Time:            " & utcTime.toString()

Dim computerTime as DateTime = DateTime(System.currentTimeMillis(), RealTimeClock.getUTCTimeZone())
print "System's Time:       " & computerTime.toString()

Dim utc4Time as DateTime = DateTime(System.currentTimeMillis(), 4)
print "UTC +4 Time:         " & utc4Time.toString()


