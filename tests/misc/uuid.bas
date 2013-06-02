# include once "ext/tests.bi"
# include once "ext/misc.bi"

namespace ext.tests.misc.uuid

    '' :::::
    private sub null_check
        dim x as ext.misc.UUID
        var y = ext.misc.UUID("{00000000-0000-0000-0000-000000000000}")
        var z = ext.misc.UUID("1234")
        var valid = ext.misc.UUID("{12345678-1234-5678-1234-567812345678}")

        ext_assert_TRUE( x.isNull )
        ext_assert_TRUE( y.isNull )
        ext_assert_TRUE( z.isNull )
        ext_assert_FALSE( valid.isNull )


    end sub

    private sub string_conversion

        var y = ext.misc.UUID("{00000000-0000-0000-0000-000000000000}")
        var valid = ext.misc.UUID("{12345678-1234-5678-1234-567812345678}")

        ext_assert_STRING_NOT_EQUAL(y,valid)
        ext_assert_STRING_EQUAL("{12345678-1234-5678-1234-567812345678}",valid)
        ext_assert_STRING_EQUAL("{00000000-0000-0000-0000-000000000000}",y)

    end sub

    '' :::::
    private sub register constructor
        ext.tests.addSuite("ext-misc-uuid")
        ext.tests.addTest("UUID Null Check", @null_check)
        ext.tests.addTest("UUID String Conversion",@string_conversion)
    end sub

end namespace
