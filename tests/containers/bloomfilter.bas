#include once "ext/testly.bi"
#include once "ext/containers/bloomfilter.bi"

namespace ext.tests.bloomf

private sub test_bf

    var bf = new ext.BloomFilter( 10 )

    bf->add("Andre Victor")
    bf->add("Brian Kerighan")
    bf->add("Dennis Ritchie")
    bf->add("Rob Pike")
    bf->add("Ruben Rodriguez")
    bf->add("Daniel Verkamp")
    bf->add("Tito Puentes")

    TESTLY_ASSERT_TRUE(bf->lookup("Dennis Ritchie"))
    TESTLY_ASSERT_TRUE(bf->lookup("Andre Victor"))
    TESTLY_ASSERT_FALSE(bf->lookup("Ben Stiller"))
    TESTLY_ASSERT_FALSE(bf->lookup("Bill Gates"))

    delete bf

end sub

private sub register constructor
    ext.testly.addSuite("Containers::BloomFilter")
    ext.testly.addTest("General",@test_bf)
end sub

end namespace
