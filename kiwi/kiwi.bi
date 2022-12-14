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
	Description: The intention of this binary include (bi) is to
	allow FreeBasic developers include the most basic Kiwi stuff to their code. 
	
	Author: Nikos Siatras
	Url: https://www.github.com/nsiatras
'/

#Define KIWI_VERSION "1.0.7"

#include once "core\Core.bi"

#include once "nio\Charset.bi"

#include once "lang\GarbageCollector.bi"
#include once "lang\KObject.bi"
#include once "lang\System.bi"
#include once "lang\Math.bi"
'#include once "lang\Thread.bi"					'It is included in KObject
'#include once "lang\ThreadsManager.bi"			'It is included in KObject
'#include once "lang\Runnable.bi"				'It is included in Thread
'#include once "lang\KiwiCallbackManager.bi" 	'It is included in KObject
#include once "lang\StringUtils.bi"

#include once "util\Collection.bi"
#include once "util\Comparator.bi"
#include once "util\ArrayList.bi"
#include once "util\Queue.bi"
#include once "util\HashMap.bi"

' Initialize the Threads manager
ThreadsManager.Initialize()


