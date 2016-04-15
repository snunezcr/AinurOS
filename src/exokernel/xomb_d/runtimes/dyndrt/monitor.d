/*
 * monitor.d
 *
 * This module implements the logic to lock objects using the synchronized
 * keyword.
 *
 * Originated: May 8th, 2010
 *
 */

module dyndrt.monitor;

import dyndrt.gc;

//import synch.semaphore;
//import synch.thread;
import libos.libdeepmajik.threadscheduler;
import synch.atomic;

//import io.console;

extern(C):

struct Monitor {
	//Semaphore semaphore;
	XombThread* owner;
	ulong count;
}

void _d_monitorenter(Object h) {
	// The monitor object is the second pointer in the object
	Monitor* monitor = *(cast(Monitor**)h + 1);
	if (monitor is null) {
		monitor = new Monitor;
		//monitor.semaphore = new Semaphore(1);
		monitor.owner = XombThread.getCurrentThread();
		monitor.count = 1;
		// TODO: Should be an atomic exchange with null, and if it fails then
		// proceed to use that object.
		*(cast(Monitor**)h + 1) = monitor;
		//monitor.semaphore.down();
	}
	else if (monitor.owner != XombThread.getCurrentThread()) {
		//monitor.semaphore.down();
	}
	else {
		Atomic.increment(monitor.count);
	}
}

void _d_monitorexit(Object h) {
	Monitor* monitor = *(cast(Monitor**)h + 1);
	if (monitor.owner != XombThread.getCurrentThread()) {
		Atomic.decrement(monitor.count);
		if (monitor.count == 0) {
			//monitor.semaphore.up();
		}
	}
	else {
		//monitor.semaphore.up();
	}
}

void _d_criticalenter(void* dcs) {
}

void _d_criticalexit(void* dcs) {
}
