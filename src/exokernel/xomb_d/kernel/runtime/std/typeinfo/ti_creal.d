
// creal

module std.typeinfo.ti_creal;

class TypeInfo_c : TypeInfo
{
    char[] toString() { return "creal"; }

    hash_t getHash(void *p)
    {
	return (cast(uint *)p)[0] + (cast(uint *)p)[1] +
	       (cast(uint *)p)[2] + (cast(uint *)p)[3] +
	       (cast(uint *)p)[4];
    }

    static int _equals(creal f1, creal f2)
    {
	return f1 == f2;
    }

    static int _compare(creal f1, creal f2)
    {   int result;

	if (f1.re < f2.re)
	    result = -1;
	else if (f1.re > f2.re)
	    result = 1;
	else if (f1.im < f2.im)
	    result = -1;
	else if (f1.im > f2.im)
	    result = 1;
	else
	    result = 0;
        return result;
    }

    int equals(void *p1, void *p2)
    {
	return _equals(*cast(creal *)p1, *cast(creal *)p2);
    }

    int compare(void *p1, void *p2)
    {
	return _compare(*cast(creal *)p1, *cast(creal *)p2);
    }

    size_t tsize()
    {
	return creal.sizeof;
    }

    void swap(void *p1, void *p2)
    {
	creal t;

	t = *cast(creal *)p1;
	*cast(creal *)p1 = *cast(creal *)p2;
	*cast(creal *)p2 = t;
    }

    void[] init()
    {	static creal r;

	return (cast(creal *)&r)[0 .. 1];
    }
}

