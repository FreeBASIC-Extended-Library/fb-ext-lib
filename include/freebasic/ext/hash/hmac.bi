''Title: hash/hmac.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

#include once "ext/hash.bi"

''Namespace: ext.hashes.hmac
namespace ext.hashes.hmac

    declare function md5 ( byref key as const string, byref msg as const string ) as string

    declare function sha256 ( byref key as const string, byref msg as const string ) as string

end namespace
