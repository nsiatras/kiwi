#include once "kiwi\kiwi.bi"
#include once "kiwi\time.bi" 

' Initialize a Calendar using the UTC+2 TimeZone
Dim myCalendar as Calendar = Calendar(+2)

' Create a new DateTime
Dim dt as DateTime = myCalendar.createTime(1940, 10, 28, 05, 15, 00)
print dt.toString()



