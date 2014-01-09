#include once "ext/tests.bi"
#include once "ext/hash/hmac.bi"

namespace ext.tests.hmac

const HMAC_TEST_STRING = "The quick brown fox jumps over the lazy dog"

private sub test_hmacmd5

    var empty = lcase(ext.hashes.hmac.md5_("",""))
    var test = lcase(ext.hashes.hmac.md5_("key",HMAC_TEST_STRING))

    EXT_ASSERT_TRUE("74e6f7298a9c2d168935f58c001bad88" = empty)
    EXT_ASSERT_TRUE("80070713463e7749b90c2dc24911e275" = test)

    ?
    ? empty
    ? test

end sub

private sub test_hmacsha256

    var empty = lcase(ext.hashes.hmac.sha256("",""))
    var test = lcase(ext.hashes.hmac.sha256("key",HMAC_TEST_STRING))

    ?
    ? empty
    ? test

    EXT_ASSERT_TRUE("b613679a0814d9ec772f95d778c35fc5ff1697c493715653c6c712144292c5ad" = empty)
    EXT_ASSERT_TRUE("f7bc83f430538424b13298e6aa6fb143ef4d59a14946175997479dbc2d1a3cd8" = test)

end sub

private sub register constructor
    ext.tests.addSuite("ext-hashes-hmac")
    ext.tests.addTest("hmac-md5",@test_hmacmd5)
    ext.tests.addTest("hmac-sha256",@test_hmacsha256)
end sub

end namespace
