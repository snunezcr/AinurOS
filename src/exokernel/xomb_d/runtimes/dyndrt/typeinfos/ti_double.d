/*
 * ti_double.d
 *
 * This module implements the TypeInfo for the double type.
 *
 */

module dyndrt.typeinfos.ti_double;

int isnan(real e) {
    ushort* pe = cast(ushort *)&e;
    ulong*  ps = cast(ulong *)&e;

    return (pe[4] & 0x7FFF) == 0x7FFF &&
	    *ps & 0x7FFFFFFFFFFFFFFF;
}

class TypeInfo_d : TypeInfo {
	char[] toString() {
		return "double";
	}

	hash_t getHash(void *p) {
		return (cast(uint *)p)[0] + (cast(uint *)p)[1];
	}

	int equals(void *p1, void *p2) {
		return _equals(*cast(double *)p1, *cast(double *)p2);
	}

	int compare(void *p1, void *p2)
	{
		return _compare(*cast(double *)p1, *cast(double *)p2);
	}

	size_t tsize() {
		return double.sizeof;
	}

	void swap(void *p1, void *p2) {
		double t;

		t = *cast(double *)p1;
		*cast(double *)p1 = *cast(double *)p2;
		*cast(double *)p2 = t;
	}

	void[] init() {
		static double r;

		return (cast(double *)&r)[0 .. 1];
	}

package:
	static int _equals(double f1, double f2) {
		return f1 == f2 ||
			(isnan(f1) && isnan(f2));
	}

	static int _compare(double d1, double d2) {
		// if either are NaN
		if (d1 !<>= d2) {
			if (isnan(d1)) {
				if (isnan(d2)) {
					return 0;
				}
				return -1;
			}

			return 1;
		}
		return (d1 == d2) ? 0 : ((d1 < d2) ? -1 : 1);
	}
}
