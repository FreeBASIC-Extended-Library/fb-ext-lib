# include once "ext/testly.bi"
# include once "ext/misc.bi"

namespace ext.tests.misc.uuid

    '' :::::
    private sub null_check
        dim x as ext.misc.UUID
        var y = ext.misc.UUID("{00000000-0000-0000-0000-000000000000}")
        var z = ext.misc.UUID("1234")
        var valid = ext.misc.UUID("{12345678-1234-5678-1234-567812345678}")

        TESTLY_ASSERT_TRUE( x.isNull )
        TESTLY_ASSERT_TRUE( y.isNull )
        TESTLY_ASSERT_TRUE( z.isNull )
        TESTLY_ASSERT_FALSE( valid.isNull )


    end sub

    private sub string_conversion

        var y = ext.misc.UUID("{00000000-0000-0000-0000-000000000000}")
        var valid = ext.misc.UUID("{12345678-1234-5678-1234-567812345678}")

        TESTLY_ASSERT_STRING_NOT_EQUAL(y,valid)
        TESTLY_ASSERT_STRING_EQUAL("{12345678-1234-5678-1234-567812345678}",valid)
        TESTLY_ASSERT_STRING_EQUAL("{00000000-0000-0000-0000-000000000000}",y)

    end sub

    '' :::::
    private sub register constructor
        ext.testly.addSuite("ext-misc-uuid")
        ext.testly.addTest("UUID Null Check", @null_check)
        ext.testly.addTest("UUID String Conversion",@string_conversion)
    end sub

end namespace
