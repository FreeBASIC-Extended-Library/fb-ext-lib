#include once "ext/tests.bi"
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

    ext_assert_TRUE(bf->lookup("Dennis Ritchie"))
    ext_assert_TRUE(bf->lookup("Andre Victor"))
    ext_assert_FALSE(bf->lookup("Ben Stiller"))
    ext_assert_FALSE(bf->lookup("Bill Gates"))

    delete bf

end sub

private sub register constructor
    ext.tests.addSuite("Containers::BloomFilter")
    ext.tests.addTest("General",@test_bf)
end sub

end namespace
