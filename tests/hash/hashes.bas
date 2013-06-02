# include once "ext/tests.bi"
# include once "ext/hash.bi"

namespace ext.tests.hashes

	const FBEXT_TEST_STRING = "FreeBASIC Extended Library Testing Testing 123"

	private sub test_adler32

		var res = ext.hashes.adler32( FBEXT_TEST_STRING )

		ext_assert_TRUE( 2001539036u = res )

	end sub

	private sub test_crc32

		var res = ext.hashes.crc32( FBEXT_TEST_STRING )

		ext_assert_TRUE( 881431911u = res )

	end sub

	private sub test_joaat32

		var res = ext.hashes.joaat( FBEXT_TEST_STRING )

		ext_assert_TRUE( 2896898767u = res )

	end sub

	private sub test_joaat64

		var res = ext.hashes.joaat64( FBEXT_TEST_STRING )

		ext_assert_TRUE( 4218073866758198310ull = res )

	end sub

	private function run_test_md5( byref in_ as const string ) as string

		dim as ext.hashes.md5.state m_state

		ext.hashes.md5.init( @m_state )
		ext.hashes.md5.append( @m_state, @(in_[0]), len(in_) )

		return ext.hashes.md5.finish( @m_state )

	end function

	private sub test_md5

	ext_assert_STRING_EQUAL( "D41D8CD98F00B204E9800998ECF8427E", run_test_md5( "" ) )
	ext_assert_STRING_EQUAL( "4D52535C7692376E7E7E205940A93AE9", run_test_md5( "945399884.61923487334tuvga" ) )
	ext_assert_STRING_EQUAL( "900150983CD24FB0D6963F7D28E17F72", run_test_md5( "abc" ) )
	ext_assert_STRING_EQUAL( "F96B697D7CB7938D525A2F31AAF161D0", run_test_md5( "message digest" ) )
	ext_assert_STRING_EQUAL( "C3FCD3D76192E4007DFB496CCA67E13B", run_test_md5( "abcdefghijklmnopqrstuvwxyz" ) )
	ext_assert_STRING_EQUAL( "D174AB98D277D9F5A5611C2C9F419D9F" ,run_test_md5( "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789" ) )
	ext_assert_STRING_EQUAL( "57EDF4A22BE3C955AC49DA2E2107B67A", _
							run_test_md5( "12345678901234567890123456789012345678901234567890123456789012345678901234567890" ) )

	end sub

	private sub test_sha2

	''Invalid
	ext_assert_STRING_EQUAL( "Invalid key length", ext.hashes.sha2.checksum( "doesn't matter", 42 ) )

	''224
	ext_assert_STRING_EQUAL( "23097d223405d8228642a477bda255b32aadbce4bda0b3f7e36c9da7", ext.hashes.sha2.checksum( "abc", 224 ) )

	''256
	ext_assert_STRING_EQUAL( "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", ext.hashes.sha2.checksum( "" ) )
	ext_assert_STRING_EQUAL( "5e698150749eafa37b277f8ad390ff407aa3c011c92d6d2a09f2056de7590908", ext.hashes.sha2.checksum( FBEXT_TEST_STRING ) )
	ext_assert_STRING_EQUAL( "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad", ext.hashes.sha2.checksum( "abc" ) )
	ext_assert_STRING_EQUAL( "6a9c3911d69fdb86d4b5a6b93dbdd9d5d3b1125551416b7af129b29936ae48e2", ext.hashes.sha2.checksum( space(60) ) )

	''384
	ext_assert_STRING_EQUAL( "38b060a751ac96384cd9327eb1b1e36a21fdb71114be07434c0cc7bf63f6e1da274edebfe76f65fbd51ad2f14898b95b", ext.hashes.sha2.checksum( "", 384 ) )
	ext_assert_STRING_EQUAL( "cb00753f45a35e8bb5a03d699ac65007272c32ab0eded1631a8b605a43ff5bed8086072ba1e7cc2358baeca134c825a7", ext.hashes.sha2.checksum( "abc", 384 ) )
	''512
	ext_assert_STRING_EQUAL( "ee180b331ce6100da9ee3be145f57281b9a0bad185be319c4b30a10ceaf0a8e17d7b0c74aa7c71db46d50b2c051dc9f02177f392f17442c0eb088801ee78fe6a", ext.hashes.sha2.checksum( FBEXT_TEST_STRING, 512 ) )
	ext_assert_STRING_EQUAL( "cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e", ext.hashes.sha2.checksum( "", 512 ) )
	ext_assert_STRING_EQUAL( "ddaf35a193617abacc417349ae20413112e6fa4e89a97ea20a9eeee64b55d39a2192992a274fc1a836ba3c23a3feebbd454d4423643ce80e2a9ac94fa54ca49f", ext.hashes.sha2.checksum( "abc", 512 ) )
	end sub

	private sub register constructor
		ext.tests.addSuite("ext-hashes")
		ext.tests.addTest("test_adler32", @test_adler32)
		ext.tests.addTest("test_crc32", @test_crc32)
		ext.tests.addTest("test_joaat", @test_joaat32)
		ext.tests.addTest("test_joaat64", @test_joaat64)
		ext.tests.addTest("test_md5", @test_md5)
		ext.tests.addTest("test_sha2", @test_sha2)
	end sub

end namespace
