/*
 * object.d
 *
 * This module implements the Object class.
 *
 */

module object;

public import dyndrt.types;
import util;

// Description: The base class inherited by all classes.
class Object {

	void dispose() {
	}

	// Description: Returns a string representing this object.
	char[] toString() {
		return this.classinfo.name;
	}

	// Description: Computes a hash representing this object
	hash_t toHash() {
		// Hash the pointer
		return hash(cast(hash_t)cast(void*)this);
	}

	// Description: Will compare two Object classes
	// Returns: 0 if equal, -1 if o is greater, 1 if o is smaller.
	int opCmp(Object o) {
		return 0;
	}

	// Description: Will compare two Object classes for equality. Defaults
	//   to a comparing references.
	// Returns: 0 if not equal.
	int opEquals(Object o) {
		return cast(int)(this is o);
	}
}

// Description: This is the information stored for an interface.
struct Interface {
	ClassInfo classinfo;		// .classinfo for this interface (not for containing class)
	void *[] vtbl;
	ptrdiff_t offset; 				// offset to Interface 'this' from Object 'this'
}

// Description: The information stored for a class. Retrieved via the .classinfo property.
//  It is stored as the first entry in the class' vtbl[].
class ClassInfo : Object {
	byte[] init;

	string name;
	void*[] vtbl;

	Interface[] interfaces;

	ClassInfo base;
	void* destructor;	
	void* classInvariant;

	uint flags;
	void* deallocator;
	OffsetTypeInfo[] offTi;

	void* defaultConstructor;

	TypeInfo typeinfo;

	static ClassInfo find(string classname) {
		// Loop through every module
		// Then loop through every class
		// Trying to find the class
		return null;
	}

	Object create() {
		// Class factory
		return null;
	}
}

public import dyndrt.typeinfo;

public import dyndrt.typeinfos.ti_array;
public import dyndrt.typeinfos.ti_array_bool;
public import dyndrt.typeinfos.ti_array_byte;
public import dyndrt.typeinfos.ti_array_cdouble;
public import dyndrt.typeinfos.ti_array_cfloat;
public import dyndrt.typeinfos.ti_array_char;
public import dyndrt.typeinfos.ti_array_creal;
public import dyndrt.typeinfos.ti_array_dchar;
public import dyndrt.typeinfos.ti_array_double;
public import dyndrt.typeinfos.ti_array_float;
public import dyndrt.typeinfos.ti_array_idouble;
public import dyndrt.typeinfos.ti_array_ifloat;
public import dyndrt.typeinfos.ti_array_int;
public import dyndrt.typeinfos.ti_array_ireal;
public import dyndrt.typeinfos.ti_array_long;
public import dyndrt.typeinfos.ti_array_object;
public import dyndrt.typeinfos.ti_array_real;
public import dyndrt.typeinfos.ti_array_short;
public import dyndrt.typeinfos.ti_array_ubyte;
public import dyndrt.typeinfos.ti_array_uint;
public import dyndrt.typeinfos.ti_array_ulong;
public import dyndrt.typeinfos.ti_array_ushort;
public import dyndrt.typeinfos.ti_array_void;
public import dyndrt.typeinfos.ti_array_wchar;
public import dyndrt.typeinfos.ti_assocarray;
//public import dyndrt.typeinfos.ti_bool;
public import dyndrt.typeinfos.ti_byte;
public import dyndrt.typeinfos.ti_cdouble;
public import dyndrt.typeinfos.ti_cfloat;
public import dyndrt.typeinfos.ti_char;
public import dyndrt.typeinfos.ti_creal;
public import dyndrt.typeinfos.ti_dchar;
public import dyndrt.typeinfos.ti_delegate;
public import dyndrt.typeinfos.ti_double;
public import dyndrt.typeinfos.ti_enum;
public import dyndrt.typeinfos.ti_float;
public import dyndrt.typeinfos.ti_function;
public import dyndrt.typeinfos.ti_idouble;
public import dyndrt.typeinfos.ti_ifloat;
public import dyndrt.typeinfos.ti_int;
public import dyndrt.typeinfos.ti_interface;
public import dyndrt.typeinfos.ti_ireal;
public import dyndrt.typeinfos.ti_long;
public import dyndrt.typeinfos.ti_object;
public import dyndrt.typeinfos.ti_ptr;
public import dyndrt.typeinfos.ti_real;
public import dyndrt.typeinfos.ti_short;
public import dyndrt.typeinfos.ti_staticarray;
public import dyndrt.typeinfos.ti_struct;
public import dyndrt.typeinfos.ti_tuple;
public import dyndrt.typeinfos.ti_typedef;
public import dyndrt.typeinfos.ti_ubyte;
public import dyndrt.typeinfos.ti_uint;
public import dyndrt.typeinfos.ti_ulong;
public import dyndrt.typeinfos.ti_ushort;
public import dyndrt.typeinfos.ti_void;
public import dyndrt.typeinfos.ti_wchar;

public import dyndrt.moduleinfo;

public import core.exception;
