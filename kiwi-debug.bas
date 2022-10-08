#include once "kiwi\kiwi.bi"
#include once "kiwi\time.bi" 

Dim myCalendar as Calendar = Calendar()

Dim currentDateTime as DateTime = myCalendar.createTime(System.currentTimeMillis())
print currentDateTime.toString()




