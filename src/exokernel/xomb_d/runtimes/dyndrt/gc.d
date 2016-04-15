/*
 * gc.d
 *
 * This module implements the D runtime functions for interfacing the
 * garbage collector.
 *
 */

module dyndrt.gc;

import synch.atomic;

//import System = scaffold.system;

//import binding.c;

import Syscall = user.syscall;
import user.environment;

private ubyte[] gcSegment;

ubyte[] System_malloc(ulong size){
	if(gcSegment is null){
		gcSegment = Syscall.create(findFreeSegment(false, oneGB*512), AccessMode.User|AccessMode.Writable|AccessMode.AllocOnAccess);
	}

	ubyte[] val = gcSegment[0..size];

	// XXX: lockfree update
	gcSegment = gcSegment[size..$];

	return val;
}


extern(C):

void gc_init() {
	GarbageCollector._initialize();
}

void gc_term() {
	GarbageCollector._terminate();
}

void gc_enable() {
	GarbageCollector.enable();
}

void gc_disable() {
	GarbageCollector.disable();
}

void gc_collect() {
	GarbageCollector.collect();
}

uint gc_getAttr(void* p) {
	return 0;
	//GarbageCollector.getAttr(p);
}

uint gc_setAttr(void* p, uint a) {
	return 0;
	//GarbageCollector.setAttr(p, a);
}

uint gc_clrAttr(void* p, uint a) {
	return 0;
	//GarbageCollector.clearAttr(p, a);
}

void* gc_malloc(size_t sz, uint ba = 0) {
	return GarbageCollector.malloc(sz).ptr;
}

void* gc_calloc(size_t sz, uint ba = 0) {
	return GarbageCollector.calloc(sz).ptr;
}

void* gc_realloc(ubyte* p, size_t sz, uint ba = 0) {
	return GarbageCollector.realloc(p[0..sz], sz).ptr;
}

size_t gc_extend(ubyte* p, size_t mx, size_t sz) {
	return GarbageCollector.extend(p[0..mx], mx, sz);
}

void gc_free(ubyte* p) {
	return GarbageCollector.free(p[0..1]);
}

size_t gc_sizeOf(ubyte* p) {
	return GarbageCollector.sizeOf(p[0..1]);
}

void gc_addRoot(ubyte* p) {
	return GarbageCollector.addRoot(p[0..1]);
}

void gc_addRange(ubyte* p, size_t sz) {
	return GarbageCollector.addRange(p[0..sz]);
}

void gc_removeRoot(ubyte* p) {
	return GarbageCollector.removeRoot(p[0..1]);
}

void gc_removeRange(ubyte* p) {
	return GarbageCollector.removeRange(p[0..1]);
}

// Implementation
struct Pool {
}

class GarbageCollector {
static:
private:

	void _initialize() {
		ubyte[] foo = System_malloc(1);
		_heapStart = cast(size_t*)foo.ptr;
		_heapEnd = cast(size_t*)(foo.ptr + 1);
		_inited = 1;
	}

	void _terminate() {
		_inited = 0;
	}

	ulong _disabled;
	bool _inited;
	size_t* _heapStart;
	size_t* _heapEnd;

public:
	void enable() {
		Atomic.decrement(_disabled);
	}

	void disable() {
		Atomic.increment(_disabled);
	}

	void minimize() {
	}

	void collect() {
	}

	ubyte[] malloc(size_t length) {
		ubyte[] ret = System_malloc(length + size_t.sizeof);
		size_t* len = cast(size_t*)ret.ptr;
		*len = length;
		ubyte* end = ret.ptr + length + size_t.sizeof;
		if (end > cast(ubyte*)_heapEnd) {
			_heapEnd = cast(size_t*)end;
		}
		return ret[size_t.sizeof..$];
	}

	ubyte[] realloc(ubyte[] original, size_t length) {
		size_t* oldlen = (cast(size_t*)original.ptr) - 1;
		if (oldlen > _heapStart && oldlen < _heapEnd) {
			if (*oldlen > length) {
				alias length innerLength;
				return original[0..innerLength];
			}
		}

		ubyte[] newArray = malloc(length);
		newArray[0..original.length] = original[0..original.length];

		return newArray;
	}

	ubyte[] calloc(size_t length) {
		ubyte[] ret = malloc(length);

		ret[0..$] = 0;

		return ret;
	}

	size_t extend(ubyte[] original, size_t max, size_t size) {
		return 0;
	}

	size_t reserve(size_t length) {
		return 0;
	}

	void free(ubyte[] memory) {
	}

	void* addressOf(ubyte[] memory) {
		return null;
	}

	size_t sizeOf(ubyte[] memory) {
		return 0;
	}

	void addRoot(ubyte[] memory) {
	}

	void addRange(ubyte[] range) {
	}

	void removeRoot(ubyte[] memory) {
	}

	void removeRange(ubyte[] range) {
	}

	size_t query(ubyte[] memory) {
		if (memory is null) {
			return 0;
		}

		size_t* oldlen = (cast(size_t*)memory.ptr) - 1;

		if (oldlen > _heapStart && oldlen < _heapEnd) {
			return *oldlen;
		}
		return memory.length;
	}
}
