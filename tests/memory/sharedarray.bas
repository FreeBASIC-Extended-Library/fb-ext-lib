# include once "ext/testly.bi"
# include once "ext/memory/sharedarray.bi"

namespace ext.tests.memory

	type VerboseType
		declare constructor
		declare destructor
		
		__ as integer
	end type
	
	dim shared m_newInstances as SizeType = 0
	dim shared m_destroyedInstances as SizeType = 0
	
	constructor VerboseType
		m_newInstances += 1
	end constructor
	
	destructor VerboseType
		m_destroyedInstances += 1
	end destructor
	
end namespace

namespace ext

    fbext_Instanciate(fbext_SharedPtrArray, ((ext)(tests)(memory)(VerboseType)))

end namespace
	
namespace ext.tests.memory

	private sub test
	
		TESTLY_ASSERT_TRUE( 0 = m_newInstances )
		TESTLY_ASSERT_TRUE( 0 = m_destroyedInstances )
		
		scope
			var sa1 = fbext_SharedPtrArray((ext)(tests)(memory)(VerboseType))(new VerboseType[3])
			
			TESTLY_ASSERT_TRUE( 3 = m_newInstances )
			TESTLY_ASSERT_TRUE( 0 = m_destroyedInstances )
			
			var sa2 = sa1
			
			TESTLY_ASSERT_TRUE( sa1.Get() = sa2.Get() )
			TESTLY_ASSERT_TRUE( 3 = m_newInstances )
			TESTLY_ASSERT_TRUE( 0 = m_destroyedInstances )
			
			sa1.Reset()
			
			TESTLY_ASSERT_TRUE( null = sa1.Get() )
			TESTLY_ASSERT_TRUE( 3 = m_newInstances )
			TESTLY_ASSERT_TRUE( 0 = m_destroyedInstances )
		
		end scope
		
		TESTLY_ASSERT_TRUE( 3 = m_newInstances )
		TESTLY_ASSERT_TRUE( 3 = m_destroyedInstances )
	
	end sub
	
	private sub register constructor
		ext.testly.addSuite("ext-memory-sharedarray")
		ext.testly.addTest("test", @test)
	end sub

end namespace
