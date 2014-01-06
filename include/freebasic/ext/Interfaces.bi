''Title: List of Interfaces
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

#print This header "Interfaces.bi" is for documentation only and won't do anything if included.

'' Interface: DefaultConstructible
''  Specifies that a type can be created without being initialized.
''
'' Procedures:
''  * constructor()
''
'' Requires:
''  * dim x as T
''  * var x = T()


'' Interface: CopyConstructible
''  Specifies that an object of the type can be created as a copy of another
''  object of the same type.
''
'' Procedures:
''  * constructor( byref rhs as const type )
''
'' Requires:
''  * dim x as T = y
''  * var x = y

'' Interface: CopyAssignable
''  Specifies that an object of the type can be assigned as a copy of another
''  object of the same type.
''
'' Procedures:
''  * operator type.Let( byref rhs as const type )
''
'' Requires:
''  * x = y

'' Interface: Copyable
''  Specifies that an object of the type can be created or assigned as a copy
''  of another object of the same type.
''
'' Requires:
''  * Conforms to the <CopyConstructible> interface.
''  * Conforms to the <CopyAssignable> interface.

'' Interface: EqualityComparable
''  Specifies that two objects of the type can be compared for equality with
''  operator =.
''
'' Procedures:
''  * operator = ( byref lhs as const type, byref rhs as const type ) as integer
''
'' Requires:
''  * (x = y)

'' Interface: InequalityComparable
'' Specifies that two objects of the type can be compared for inequality with operator <>.
''
'' Procedures:
''  * operator <> ( byref lhs as const type, byref rhs as const type ) as integer
''
'' Requires:
''  * (x <> y)

'' Interface: LessThanComparable
''  Specifies that two objects of the type can be ordered with operator <.
''
'' Procedures:
''  * operator < ( byref lhs as const type, byref rhs as const type ) as integer
''
'' Requires:
''  * (x < y)

'' Interface: GreaterThanComparable
''  Specifies that two object of the type can be ordered with operator >.
''
'' Procedures:
''  * operator > ( byref lhs as const type, byref rhs as const type ) as integer
''
'' Requires:
'' * (x > y)

'' Interface: Comparable
'' Specifies that two objects of the type can be compared using the most common comparison operators.
''
'' Requires:
''  * Conforms to the <EqualityComparable> interface.
''  * Conforms to the <InequalityComparable> interface.
''  * Conforms to the <LessThanComparable> interface.
''  * Conforms to the <GreaterThanComparable> interface.

'' Interface: Printable
''  Specifies that an object of the type can be converted to a String value.
''
'' Procedures:
''  * operator type.cast() as string
''
'' Requires:
''  * dim s as string = x

'' Interface: Serializable
''  Specifies that an object of the type can be loaded from it's string representation.
''
'' Requires:
''  * Conforms to the <Printable> interface.
''
'' Procedures:
''  * operator let( byref rhs as const string )
''  * function fromString( byref rhs as const string ) as bool

