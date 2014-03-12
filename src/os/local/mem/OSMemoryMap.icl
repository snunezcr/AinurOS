/*
 * AinurOS: a Functional Exascale Operating System
 * Santiago Nunez-Corrales (santiago@fuper.cr)
 * Copyright 2014
 *
 * This file is part of AinurOS.
 *
 * AinurOS is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * AinurOS is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with AinurOS.  If not, see <http://www.gnu.org/licenses/>
 */

implementation module OSMemoryMap

import OSProcess
import OSStatus
import OSType

::OSPhyAddr		= OSRawInt

::OSVirtAddr		= OSRawLongInt

::OSAddr		= OSRawLongInt

::OSMemPage		= { start_addr :: OSVirtAddr
			  , size :: OSRawLongInt
			  , offset :: OSRawLongInt
			  , locked :: OSBool
			  , data :: .{!OSRawByte}
			  }

/*
 * System data types with length 0 indicate an array of objects of the same inner
 * type. All arrays will be strict and unique in this memory management unit.
 */
::OSMemType		= (OSBit,1)
			| (OSBool,1)
			| (OSByte,1)
			| (OSRawByte,1)
			| (OSChar,1)
			| (OSInt,4)
			| (OSRawInt,4)
			| (OSLongInt,8)
			| (OSRawLongInt,8)
			| (OSShort,2)
			| (OSDouble,4)
			| (OSLongDouble,8)
			| (OSString,0)

::OSMemDatum

::OSMemMap

::OSMemSegment

osmmap_phys_to_virt :: OSPhysAddr -> OSPageSpecs -> OSVirtAddr

osmmap_virt_to_phys :: OSVirtAddr -> OSPageSpecs -> OSPhysAddr

osmmap_page_size :: OSMemPageSpecs -> Int

osmmap_page_offset_size :: OSMemPageSpecs -> Int

osmmap_page_unsafe_read :: OSVirtAddr -> (Int,[OSMemDatum])

osmmap_page_unsafe_write :: OSVirtAddr -> (Int, [OSMemDatum]) -> OSStatus

osmmap_page_safe_read :: OSVirtAddr -> OSMemType -> OSMemMap -> (Int,[OSMemDatum])

osmmap_page_safe_write :: OSVirtAddr -> (Int, [OSMemDatum]) -> OSMemMap -> OSStatus

osmmap_unsafe_read :: OSVirtAddr -> OSMemType -> OSMemDataType -> OSMemDatum

osmmap_unsafe_write :: OSVirtAddr -> OSMemDataType -> OSMemDatum -> OSStatus

osmmap_safe_read :: OSVirtAddr -> OSMemDataType -> OSMemMap -> OSMemDatum

osmmap_safe_write :: OSVirtAddr -> OSMemDataType -> OSMemMap -> OSMemLock -> OSStatus

osmmap_segment_alloc :: OSMemMap -> OSVirtAddr -> (OSMemSegment,OSMemMap)

osmmap_segment_coalesce :: OSMemMap -> [OSVirtAddr] -> (OSMemSegment,OSMemMap)

osmmap_segment_refine ::OSMemMap -> OSVirtAddr -> (OSMemSegment,OSMemMap)

osmmap_segment_dealloc ::OSMemMap -> OSVirtAddr -> (OSMemMap,OSStatus)

osmmap_segment_at :: OSMemMap -> OSVirtAddr -> (OSMemSegment,OSStatus)

osmmap_reserved :: OSVirtAddr -> OSMemMap -> Bool

osmmap_locked :: OSVirtAddr -> OSMemMap -> Bool

osmmap_collectible :: OSVirtAddr -> OSMemMap -> Bool

osmmap_owner :: OSVirtAddr -> OSMemMap -> OSProcID

osmmap_page_show :: OSMemPage -> String

osmmap_addr_show :: OSAddr -> String

osmmap_segment_show :: OSAddr -> String

osmmap_map_show :: OSMemMap -> String
