
module std.typeinfo.ti_Ashort;

import kernel.runtime.util;

// short[]

class TypeInfo_As : TypeInfo
{
    char[] toString() { return "short[]"; }

    hash_t getHash(void *p)
    {	short[] s = *cast(short[]*)p;
	size_t len = s.length;
	short *str = s.ptr;
	hash_t hash = 0;

	while (1)
	{
	    switch (len)
	    {
		case 0:
		    return hash;

		case 1:
		    hash *= 9;
		    hash += *cast(ushort *)str;
		    return hash;

		default:
		    hash *= 9;
		    hash += *cast(uint *)str;
		    str += 2;
		    len -= 2;
		    break;
	    }
	}

	return hash;
    }

    int equals(void *p1, void *p2)
    {
	short[] s1 = *cast(short[]*)p1;
	short[] s2 = *cast(short[]*)p2;

	return s1.length == s2.length &&
	       memcmp(cast(ubyte*)s1.ptr, cast(ubyte*)s2.ptr, s1.length * short.sizeof) == 0;
    }

    int compare(void *p1, void *p2)
    {
	short[] s1 = *cast(short[]*)p1;
	short[] s2 = *cast(short[]*)p2;
	size_t len = s1.length;

	if (s2.length < len)
	    len = s2.length;
	for (size_t u = 0; u < len; u++)
	{
	    int result = s1[u] - s2[u];
	    if (result)
		return result;
	}
	if (s1.length < s2.length)
	    return -1;
	else if (s1.length > s2.length)
	    return 1;
	return 0;
    }

    size_t tsize()
    {
	return (short[]).sizeof;
    }

    uint flags()
    {
	return 1;
    }

    TypeInfo next()
    {
	return typeid(short);
    }
}


// ushort[]

class TypeInfo_At : TypeInfo_As
{
    char[] toString() { return "ushort[]"; }

    int compare(void *p1, void *p2)
    {
	ushort[] s1 = *cast(ushort[]*)p1;
	ushort[] s2 = *cast(ushort[]*)p2;
	size_t len = s1.length;

	if (s2.length < len)
	    len = s2.length;
	for (size_t u = 0; u < len; u++)
	{
	    int result = s1[u] - s2[u];
	    if (result)
		return result;
	}
	if (s1.length < s2.length)
	    return -1;
	else if (s1.length > s2.length)
	    return 1;
	return 0;
    }

    TypeInfo next()
    {
	return typeid(ushort);
    }
}

// wchar[]

class TypeInfo_Au : TypeInfo_At
{
    char[] toString() { return "wchar[]"; }

    TypeInfo next()
    {
	return typeid(wchar);
    }
}


