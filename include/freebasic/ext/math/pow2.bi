''Title: math/pow2.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_MATH_POW2_BI__
# define FBEXT_MATH_POW2_BI__ -1

# include once "ext/math/detail/common.bi"

'' Namespace: ext.math
namespace ext.math

    # macro fbext_Math_NextPow2_Declare(NumericType_)
    :
    	''Function: NextPow2
    	''Finds the next power of 2 after a number.
    	''
    	''Overloaded to work with all numeric types.
    	''
    	''Parameters:
    	''ds - the number to find the next power of 2 after.
    	''
    	''Returns:
    	''The next power of 2.
    	''
    	declare function NextPow2 overload ( byval ds as fbext_TypeName(NumericType_) ) as fbext_TypeName(NumericType_)
    :
    # endmacro
    
    # macro fbext_Math_NextPow2_Define(linkage_, NumericType_)
    :
    	linkage_ function NextPow2 ( byval ds As fbext_TypeName(NumericType_) ) As fbext_TypeName(NumericType_)
    	
    		dim as fbext_TypeName(NumericType_) x = ds
    		dim as uinteger sz = (len( x ) * 8) / 2
    		dim as uinteger n = 1
    	
    		while n <= sz
    			x = x Or (x Shr n)
    			n = n ^ 2
    		wend
    	'This function rounds an T to the next power of 2
    		Return x + 1
    	
    	end function
    :
    # endmacro
    
    # macro fbext_Math_RoundPow2_Declare(NumericType_)
    :
    	''Function: RoundPow2
    	''Finds the next power of 2 after a number only if the number passed is not a power of 2 already.
    	''
    	''Overloaded to work with all numeric types.
    	''
    	''Parameters:
    	''ds - the number to find the next power of 2 after.
    	''
    	''Returns:
    	''The next power of 2 if ds is not a power of 2, ds otherwise.
    	''
    	declare function RoundPow2 overload ( byval n as fbext_TypeName(NumericType_) ) as fbext_TypeName(NumericType_)
    :
    # endmacro

    # macro fbext_Math_RoundPow2_Define(linkage_, NumericType_)
    :
    	linkage_ function RoundPow2 ( byval ds as fbext_TypeName(NumericType_) ) as fbext_TypeName(NumericType_)
    		dim as fbext_TypeName(NumericType_) x = ds - 1
    		dim as uinteger sz = (len( x ) * 8) / 2
    		dim as uinteger n = 1
    	
    		while n <= sz
    			x = x Or (x Shr n)
    			n = n ^ 2
    		wend
    	'Rounds to the next power of 2 only if not already a power of 2
    		return x + 1
    	end function
    :
    # endmacro
    
    # macro fbext_Math_IsPow2_Declare(NumericType_)
    :
    	''Function: IsPow2
    	''Determines if the number passed is a power of 2.
    	''
    	''Overloaded to work with all numeric types.
    	''
    	''Parameters:
    	''xx - the number to check.
    	''
    	''Returns:
    	''True if the number is a power of two.
    	''
    	declare function IsPow2 overload ( byval n as fbext_TypeName(NumericType_) ) as ext.bool
    :
    # endmacro

    # macro fbext_Math_IsPow2_Define(linkage_, NumericType_)
    :
    	linkage_ function IsPow2 ( byval n as fbext_TypeName(NumericType_) ) as ext.bool
    	    return not (n and (n - 1))
    	end function
    :
    # endmacro
    
    fbext_InstanciateMulti(fbext_Math_NextPow2, fbext_NumericTypes())
    fbext_InstanciateMulti(fbext_Math_RoundPow2, fbext_NumericTypes())
    fbext_InstanciateMulti(fbext_Math_IsPow2, fbext_NumericTypes())

end namespace 'ext.math

# endif ' include guard
