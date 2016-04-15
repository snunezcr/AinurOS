/*
 * ti_delegate.d
 *
 * This module implements the TypeInfo for the delegate type.
 *
 * License: Public Domain
 *
 */

module mindrt.typeinfo.ti_delegate;

class TypeInfo_D : TypeInfo {
	hash_t getHash(void *p) {
		long l = *cast(long *)p;

		return cast(uint)(l + (l >> 32));
	}

	int equals(void *p1, void *p2) {
		return *cast(dg *)p1 == *cast(dg *)p2;
	}

	size_t tsize() {
		return dg.sizeof;
	}

	void swap(void *p1, void *p2) {
		dg t;

		t = *cast(dg *)p1;
		*cast(dg *)p1 = *cast(dg *)p2;
		*cast(dg *)p2 = t;
	}

	uint flags() {
		return 1;
	}

	private alias void delegate(int) dg;

}

