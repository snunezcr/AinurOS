/*
 * ti_array_ireal.d
 *
 * This module implements the TypeInfo for ireal[]
 *
 */

module dyndrt.typeinfos.ti_array_ireal;

import dyndrt.typeinfos.ti_array_real;

class TypeInfo_Aj : TypeInfo_Ae {
	char[] toString() {
		return "ireal[]";
	}

	TypeInfo next() {
		return typeid(ireal);
	}
}
