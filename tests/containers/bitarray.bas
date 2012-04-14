# include once "ext/testly.bi"
# include once "ext/strings.bi"
# include once "ext/containers/bitarray.bi"

namespace ext.tests.bitholder

        private sub ba_dump_eq

                var bt = ext.strings.repeat("1000111011", 5)
                var ba = ext.bitarray(50)

                ba.load( bt )

                testly_assert_true( bt = ba.dump() )

        end sub

        private sub ba_load_accuracy

                var bt = "1000111011"
                var ba = ext.bitarray(10)

                ba.load(bt)

                testly_assert_true( ext.bool.true = ba.isSet(9) )
                testly_assert_true( ext.bool.false = ba.isSet(8) )
                testly_assert_true( ext.bool.false = ba.isSet(7) )
                testly_assert_true( ext.bool.false = ba.isSet(6) )
                testly_assert_true( ext.bool.true = ba.isSet(5) )
                testly_assert_true( ext.bool.true = ba.isSet(4) )
                testly_assert_true( ext.bool.true = ba.isSet(3) )
                testly_assert_true( ext.bool.false = ba.isSet(2) )
                testly_assert_true( ext.bool.true = ba.isSet(1) )
                testly_assert_true( ext.bool.true = ba.isSet(0) )

        end sub

        private sub ba_set_accuracy

                var ba = ext.bitarray(10)

                ba.set(9)
                ba.set(5)
                ba.set(4)
                ba.set(3)
                ba.set(1)
                ba.set(0)

                testly_assert_true( ext.bool.true = ba.isSet(9) )
                testly_assert_true( ext.bool.false = ba.isSet(8) )
                testly_assert_true( ext.bool.false = ba.isSet(7) )
                testly_assert_true( ext.bool.false = ba.isSet(6) )
                testly_assert_true( ext.bool.true = ba.isSet(5) )
                testly_assert_true( ext.bool.true = ba.isSet(4) )
                testly_assert_true( ext.bool.true = ba.isSet(3) )
                testly_assert_true( ext.bool.false = ba.isSet(2) )
                testly_assert_true( ext.bool.true = ba.isSet(1) )
                testly_assert_true( ext.bool.true = ba.isSet(0) )

        end sub

        private sub ba_tog_accuracy

                var ba = ext.bitarray(10)

                ba.toggle(9)
                ba.toggle(8) : ba.toggle(8)
                ba.toggle(7) : ba.toggle(7)
                ba.toggle(6) : ba.toggle(6)
                ba.toggle(5)
                ba.toggle(4)
                ba.toggle(3)
                ba.toggle(2) : ba.toggle(2)
                ba.toggle(1)
                ba.toggle(0)

                testly_assert_true( ext.bool.true = ba.isSet(9) )
                testly_assert_true( ext.bool.false = ba.isSet(8) )
                testly_assert_true( ext.bool.false = ba.isSet(7) )
                testly_assert_true( ext.bool.false = ba.isSet(6) )
                testly_assert_true( ext.bool.true = ba.isSet(5) )
                testly_assert_true( ext.bool.true = ba.isSet(4) )
                testly_assert_true( ext.bool.true = ba.isSet(3) )
                testly_assert_true( ext.bool.false = ba.isSet(2) )
                testly_assert_true( ext.bool.true = ba.isSet(1) )
                testly_assert_true( ext.bool.true = ba.isSet(0) )

        end sub


        private sub register constructor
                ext.testly.addSuite("ext-containers-bitarray")
                ext.testly.addTest("bitarray dump equality", @ba_dump_eq)
                ext.testly.addTest("bitarray load accuracy", @ba_load_accuracy)
                ext.testly.addTest("bitarray set accuracy", @ba_set_accuracy)
                ext.testly.addTest("bitarray tog accuracy", @ba_tog_accuracy)

        end sub

end namespace
