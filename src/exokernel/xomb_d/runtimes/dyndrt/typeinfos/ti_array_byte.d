/*
 * ti_array_byte.d
 *
 * This module implements the TypeInfo for a byte[]
 *
 */

module dyndrt.typeinfos.ti_array_byte;

import dyndrt.typeinfos.ti_array;

class TypeInfo_Ag : ArrayInfo!("byte") { }
