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
	Description: ThreadsManager holds a list with every Thread that
	is initialized. Each thread notifies the ThreadsManager when it 
	Initializes and Destroys so the ThreadManager always holds a list
	with the live threads.

	Author: Nikos Siatras (https://github.com/nsiatras)
'/

#include once "Thread.bi"
Type ThreadsManager extends Object

	private:
		Static fLock As Any Ptr
		Static fThreadsList(any) as Thread Ptr
		Static fCount as UInteger 
		Static fInitialized as Boolean
		
		Static fMainThread as Thread 	' Holds a virtual main thread
		
		declare static sub ResizeThreadsList(items as Integer)

	public:
		declare static sub Initialize()
		declare static sub ThreadInitialized(byref th as Thread)
		declare static sub ThreadDestroyed(byref th as Thread)
		
		declare static function getThread(threadHandle as Any Ptr) byref as Thread
		
End Type

Dim ThreadsManager.fLock As Any Ptr
Dim ThreadsManager.fMainThread As Thread = Thread()
Dim ThreadsManager.fThreadsList(any) as Thread Ptr
Dim ThreadsManager.fCount as UInteger = 0
Dim ThreadsManager.fInitialized as Boolean = false

/'
	Initializes the ThreadManager
'/
sub ThreadsManager.Initialize()
	if ThreadsManager.fInitialized = false then
		ThreadsManager.fLock = MutexCreate()
		ThreadsManager.fMainThread.setName("Main Thread")
		ThreadsManager.fCount = 0
		ThreadsManager.fInitialized = true
	end if
end sub

/'
	Each thread calls this method upon Initialization.
'/
sub ThreadsManager.ThreadInitialized(byref th as Thread)
	MutexLock (ThreadsManager.fLock)
		' Add the thread fThreadsList
		ThreadsManager.ResizeThreadsList(+1)
		ThreadsManager.fThreadsList(ThreadsManager.fCount - 1) =  @th
	MutexUnlock (ThreadsManager.fLock)
end sub

/'
	Each thread calls this method upon Destruction.
'/
sub ThreadsManager.ThreadDestroyed(byref th as Thread)
	MutexLock (ThreadsManager.fLock)

		' Find the threads index inside ThreadsManager.fThreadsList
		Dim index as Integer = -1
		for i as Integer = 0 to fCount - 1
			if (*ThreadsManager.fThreadsList(i)).getThreadHandle() = th.getThreadHandle() then
				index = i
				exit for
			end if
		next
		
		if index > -1 then
			' Removal of the last item of the list
			if index = (ThreadsManager.fCount-1) then
				ThreadsManager.ResizeThreadsList(-1)
				MutexUnLock (ThreadsManager.fLock)
				exit sub
			endif
			
			' The list has only 2 elements and we have to remove the first
			if (index = 0) and (ThreadsManager.fCount < 3) then
				ThreadsManager.fThreadsList(0) = ThreadsManager.fThreadsList(1)
				ThreadsManager.ResizeThreadsList(-1)
				MutexUnLock (ThreadsManager.fLock)
				exit sub
			endif
			
			' The rest of the code applies for 3 or more elements.
			' Move the elements to be moved...
			Dim elementsToMove as const uinteger = ThreadsManager.fCount - 1 - index
			memcpy(@ThreadsManager.fThreadsList(index), @ThreadsManager.fThreadsList(index + 1), elementsToMove * sizeOf(Thread Ptr) )
			ThreadsManager.ResizeThreadsList(-1)
		end if	
		
	MutexUnlock (ThreadsManager.fLock)
end sub

/'
	Returns the thread of the given thread Handle.
'/
function ThreadsManager.getThread(threadHandle as Any Ptr) byref as Thread
	MutexLock (ThreadsManager.fLock)
		Dim found as boolean = false
		
		' Seatch ThreadsManager.fThreadsList and find the thread
		' from the given ThreadHandle
		if ThreadsManager.fCount > 0 then
			for i as Integer = 0 to UBound(ThreadsManager.fThreadsList)
				if (*ThreadsManager.fThreadsList(i)).getThreadHandle() = threadHandle then
					function = (*ThreadsManager.fThreadsList(i))
					found = true
					MutexUnlock (ThreadsManager.fLock)
					exit for
				end if
			next 
		end if
		
		' Thread with the given thread handle wasn't found.
		' Return the main thread
		if found = false then
			function = ThreadsManager.fMainThread
		end if	
	MutexUnlock (ThreadsManager.fLock)
end function

/'
	Resizes the thread's list
'/
sub ThreadsManager.ResizeThreadsList(itemsToAdd as Integer)
	ThreadsManager.fCount += itemsToAdd
	redim preserve ThreadsManager.fThreadsList(fCount)
end sub



