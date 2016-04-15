/*
 * ti_array_byte.d
 *
 * This module implements the TypeInfo for a byte[]
 *
 * License: Public Domain
 *
 */

module mindrt.typeinfo.ti_array_byte;

import mindrt.typeinfo.ti_array;

class TypeInfo_Ag : ArrayInfo!("byte") { }
