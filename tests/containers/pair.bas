# define fbext_NoBuiltinInstanciations() 1
# include once "ext/testly.bi"
# include once "ext/containers/pair.bi"

fbext_Instanciate(fbext_Pair, ((string))((integer)))

namespace ext.tests.containers

	type PairType as fbext_Pair(((string))((integer)))

	private sub test_pair_construct

		var identity = PairType()
		TESTLY_ASSERT_TRUE( identity.first = "" )
		TESTLY_ASSERT_TRUE( identity.second = 0 )

		var pair = PairType( "test", 1.5 )
		TESTLY_ASSERT_TRUE( pair.first = "test" )
		TESTLY_ASSERT_TRUE( pair.second = 2 )

	end sub

	private sub test_pair_compare

		var pair1 = PairType( "testing", 97 )
		var pair2 = PairType( "resting", 86 )

		TESTLY_ASSERT_TRUE( pair1 > pair2 )
		TESTLY_ASSERT_TRUE( pair1 <> pair2 )

	end sub

	private sub test_pair_assign
	
		var a = PairType( "abc", 123 )
		var b = PairType( "def", 456 )
		var c = PairType()

		c = b
		TESTLY_ASSERT_TRUE( c.first = "def" )
		TESTLY_ASSERT_TRUE( c.second = 456 )
		c = a
		TESTLY_ASSERT_TRUE( c.first = "abc" )
		TESTLY_ASSERT_TRUE( c.second = 123 )
	
	end sub

	'' relops

	enum ResultFlag
		LT = &b1
		GT = &b10
		NE = &b100
		EQ = &b1000
	end enum
	
	type InputAndResult
		declare constructor ( byref as const PairType, byref as const PairType, byval as ResultFlag )
		lhs as PairType
		rhs as PairType
		flags as ResultFlag
	end type
	
	private constructor InputAndResult ( byref lhs as const PairType, byref rhs as const PairType, byval flags as ResultFlag )
		this.lhs = lhs
		this.rhs = rhs
		this.flags = flags
	end constructor

	' can't use "..." upper bounds for some reason, and can't use const
	' elements because the relop overloads have to have non-const params. :(
	dim shared irtable(1 to 9) as InputAndResult = _
	{ _ '                      lhs                 rhs           flags
		InputAndResult( PairType( "b", 2 ), PairType( "a", 1 ), GT or NE ) _
	  , InputAndResult( PairType( "b", 2 ), PairType( "a", 2 ), GT or EQ ) _
	  , InputAndResult( PairType( "b", 2 ), PairType( "a", 3 ), GT or NE ) _
	  , InputAndResult( PairType( "b", 2 ), PairType( "b", 1 ), GT or EQ ) _
	  , InputAndResult( PairType( "b", 2 ), PairType( "b", 2 ), GT or EQ ) _
	  , InputAndResult( PairType( "b", 2 ), PairType( "b", 3 ), GT or EQ ) _
	  , InputAndResult( PairType( "b", 2 ), PairType( "c", 1 ), GT or NE ) _
	  , InputAndResult( PairType( "b", 2 ), PairType( "c", 2 ), GT or EQ ) _
	  , InputAndResult( PairType( "b", 2 ), PairType( "c", 3 ), LT or NE ) _
	  _ ' ...
	}

	private sub test_pair_relops

		for i as integer = lbound( irtable ) to ubound( irtable )
			var ir = @irtable(i)
			var msg = "lhs{" & ir->lhs.first & "," & ir->lhs.second & "}"   _
					& ", rhs{" & ir->rhs.first & "," & ir->rhs.second & "}" _
					' .

			# define OPFLAG_SEQ()             ((<,LT)) ((>,GT)) ((<>,NE)) ((=,EQ))
			# define TEST_RELOP( __, opflag_) TEST_RELOP_I opflag_
			# macro TEST_RELOP_I( op_, flag_)
			:
			scope
				var expected = (ir->flags and (flag_)) <> 0
				var actual = ir->lhs op_ ir->rhs
				ext.testly.CustomAssertion( actual = expected                _
										  , __FILE__, __LINE__               _
										  , msg & ", op{" #op_ "}"           _
											& ", expected{" & expected & "}" _
											& ", actual{" & actual & "}"     _
										  )
			end scope
			:
			# endmacro

			fbextPP_SeqForEach( TEST_RELOP, __, OPFLAG_SEQ() )

			# undef TEST_RELOP_I
			# undef TEST_RELOP
			# undef OPFLAG_SEQ
		next i

	end sub

	private sub register constructor
		ext.testly.addSuite("ext-containers-pair")
		ext.testly.addTest("test_pair_construct", @test_pair_construct)
		ext.testly.addTest("test_pair_compare", @test_pair_compare)
		ext.testly.addTest("test_pair_assign", @test_pair_assign)
		ext.testly.addTest("test_pair_relops", @test_pair_relops)
	end sub

end namespace
