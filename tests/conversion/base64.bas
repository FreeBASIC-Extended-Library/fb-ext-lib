# include once "ext/tests.bi"
# include once "ext/conversion/base64.bi"

namespace ext.tests.conversion.base64

    const hw_base64 = "SGVsbG8sIFdvcmxkIQ=="
    const hellow = "Hello, World!"

    private sub test_base64_encode

        var enc64 = ext.conversion.base64.encode( hellow )

        ext_assert_STRING_EQUAL( hw_base64, enc64 )

    end sub

    function stringcompare( byref rhs as const string, byref lhs as const string ) as ext.bool

        var len_r = len(rhs) - 1
        var len_l = len(lhs) - 1

        var len_u = len_r
        if len_l < len_r then len_u = len_l

        for n as integer = 0 to len_u
            if rhs[n] <> lhs[n] then return false
        next

        return true

    end function

    private sub test_base64_decode

        var dec64 = ""
        ext.conversion.base64.decode( dec64, hw_base64 )

        ext_assert_TRUE( stringcompare(hellow, dec64) )

    end sub

    private sub register constructor
        ext.tests.addSuite("ext-base64")
        ext.tests.addTest("test_base64_encode", @test_base64_encode)
        ext.tests.addTest("test_base64_decode", @test_base64_decode)
    end sub

end namespace
