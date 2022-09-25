/'
	MIT License

	Copyright (c) 2022 Nikos Siatras

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in all
	copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
	SOFTWARE.
'/

/'
	Description: A thread is a thread of execution in a program. 
	Kiwi allows an application to have multiple threads of execution 
	running concurrently.
	
	Author: Nikos Siatras (https://github.com/nsiatras)
'/

#include once "Runnable.bi"
#include once "fbthread.bi"

Type Thread extends KObject
	
	protected:
		Declare Static Sub RunTheRunnable(r as Any PTR)
		
	private:
		Dim fThreadID As Any Ptr
		
		Dim fMyRunnablePointer as Runnable Ptr
		Dim fMyName as String
		

	public:
		declare constructor()
		declare constructor(r as Runnable Ptr )
		declare constructor(r as Runnable Ptr, threadName as String)
		declare Sub Start()
		
		
		declare function getName() as String

End Type

constructor Thread()

end constructor

constructor Thread(r as Runnable Ptr)
	fMyRunnablePointer = r
end constructor

constructor Thread(r as Runnable Ptr, threadName as String)
	fMyRunnablePointer = r
	fMyName = threadName
end constructor

Sub Thread.start()
	'fThreadID = ThreadCall Thread.RunTheRunnable(fMyRunnablePointer)
	'ThreadWait fThreadID
	
	fThreadID = ThreadCreate(@Thread.RunTheRunnable, fMyRunnablePointer)
	ThreadDetach(fThreadID)
	
End Sub

Sub Thread.RunTheRunnable(r as Any Ptr)
	print "RUN"
	Dim pp As Runnable Ptr
	pp = Cast(Runnable ptr,r)
	pp->run
		
End Sub


/'
	Return the Thread's name
'/
function Thread.getName() as String
	return fMyName
end function


