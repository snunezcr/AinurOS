/*
 * ti_array_dchar.d
 *
 * This module implements the TypeInfo for dchar[]
 *
 * License: Public Domain
 *
 */

module mindrt.typeinfo.ti_array_dchar;

import mindrt.typeinfo.ti_array;

class TypeInfo_Aw : ArrayInfo!("dchar") { }
