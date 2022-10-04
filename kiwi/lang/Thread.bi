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
	Description: A Thread is a thread of execution in a program. 
	Kiwi allows an application to have multiple threads of execution 
	running concurrently.
	
	Author: Nikos Siatras (https://github.com/nsiatras)
'/

#include once "fbthread.bi"
#include once "Runnable.bi"

Type Thread extends KObject
	
	protected:
		Declare Static Sub StartThreadWithRunnable(r as Any PTR)
		Dim fIsAlive as Boolean = false
		
	private:	
		Dim fMyThreadHandle As Any Ptr 	' The thread's handle
		Dim fMyLock As Any Ptr			' The thread's lock object (MutexCreate())
		Dim fMyRunnablePointer as Runnable Ptr = 0
		Dim fMyName as String

	public:
		declare constructor()
		declare constructor(byref r as Runnable)
		declare constructor(byref r as Runnable, threadName as String)
		declare destructor()
		
		declare sub Initialize()
		
		declare Sub start()
		declare Sub run()
		
		' Getters and Setters
		declare function getName() as String
		declare sub setName(newName as String)
		declare function isAlive() as Boolean
		declare function getThreadHandle() as Any Ptr
		declare function getThreadLock() as Any Ptr
		
		' Statics
		declare static function currentThread() byref as Thread
		declare static sub pause(ms as Long)
		
End Type

' Include  "ThreadsManager.bi" in order to make cross reference possible
#include once "ThreadsManager.bi"

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' ThreadAndRunnableContainer holds a pointer of a Thread and a pointer
' of a Runnable Instance
' WARNING: NEVER USE UNION FOR THIS TYPE
Type ThreadAndRunnableContainer
	fThread as Thread PTR
	fRunnable as Runnable PTR
End Type
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

constructor Thread()
	this.fMyName = ""
	this.Initialize()
end constructor

constructor Thread(byref r as Runnable)
	this.fMyRunnablePointer = @r
	this.fMyName = ""
	this.Initialize()
end constructor

constructor Thread(byref r as Runnable, threadName as String)
	this.fMyRunnablePointer = @r
	this.fMyName = threadName
	this.Initialize()
end constructor

/'
	This sub initializes the thread and is designed to be called from 
	the constructors.
'/
sub Thread.Initialize()
	' Inform ThreadsManager for the newely initialized thread
	ThreadsManager.ThreadInitialized(this)
	
	' Create a Mutex
	this.fMyLock = MutexCreate()
end sub

destructor Thread()
	' Inform ThreadsManager that the thread is been destroyed
	ThreadsManager.ThreadDestroyed(this)
	Mutexdestroy(this.fMyLock)
end destructor

/'
	Causes this thread to begin execution
'/
Sub Thread.start()

	' Create a container that contains a pointer of the Thread
	' and the pointer of the Runnable
	Dim container as ThreadAndRunnableContainer PTR = new ThreadAndRunnableContainer
	container->fThread = @this
	container->fRunnable = fMyRunnablePointer
			
	' Call ThreadCreate for Thread.RunTheRunnable and pass the container 
	' to the parameters
	this.fMyThreadHandle = ThreadCreate(@Thread.StartThreadWithRunnable, container )
	ThreadDetach(fMyThreadHandle)
	
End Sub

Sub Thread.StartThreadWithRunnable(r as Any Ptr)
	
	Dim container as ThreadAndRunnableContainer Ptr = CAST(ThreadAndRunnableContainer Ptr,r)
	
	' Mark Thread as Alive
	(*container).fThread->fIsAlive = true
	
	' Run the Runnable
	(*container).fRunnable->run() 

	' Mark Thread as NOT Alive
	(*container).fThread->fIsAlive = false
	
	' Delete the container 
	Delete container
	
End Sub

/'
	If this thread was constructed using a separate Runnable run object, 
	then that Runnable object's run method is called otherwise, 
	this method does nothing and returns.
'/
Sub Thread.run()
	if fMyRunnablePointer <> 0 then
		(*fMyRunnablePointer).run()
	end if
End Sub

/'
	Return the Thread's name
'/
function Thread.getName() as String
	return this.fMyName
end function

/'
	Changes the name of this thread to be equal to the argument "newName".
	
	@param newName is the new name for this thread.
'/
sub Thread.setName(newName as String) 
	this.fMyName = newname
end sub

/'
	Returns true if this thread is alive otherwise false. 
	A thread is alive if it has been started and has not yet died.
	
	@return true if this thread is alive otherwise false.
'/
function Thread.isAlive() as Boolean
	return this.fIsAlive
end function

/'
	Returns the ThreadHandle of this thread. This method is mainly used
	from ThreadsManager in order to identify threads.
'/
function Thread.getThreadHandle() as Any PTR
	return this.fMyThreadHandle
end function

/'
	Returns the ThreadLock of this thread. This method is mainly used
	from Thread.sleep method
'/
function Thread.getThreadLock() as Any PTR
	return this.fMyLock
end function


/'
	Returns the current thread instance
'/
function Thread.currentThread() byref as Thread
	Dim byref result as Thread = ThreadsManager.getThread(THREADSELF)
	return result
end function

/'
	Causes the currently executing thread to sleep (temporarily cease
    execution) for the specified number of milliseconds, subject to
    the precision and accuracy of system timers and schedulers. The thread
    does not lose ownership of any monitors.
'/
sub Thread.pause(ms as Long)
	sleep(ms,1)
end sub
