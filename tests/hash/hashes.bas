# include once "ext/tests.bi"
# include once "ext/hash.bi"
# include once "crt/string.bi"

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

	private function run_test_md5( byref in_ as  string ) as string

		return ext.hashes.md5( in_ )

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

	'' SHA Validation System (SHAVS) Test Vectors for byte oriented messages
	'' from FIPS 180-4 posted on https://csrc.nist.gov/Projects/Cryptographic-Algorithm-Validation-Program/Secure-Hashing
	dim as ubyte vec_0 = &h00

	dim as ubyte vec_224_1 = &h84
	dim as ubyte vec_256_1 = &hd3
	dim as ubyte vec_384_1 = &hc5
	dim as ubyte vec_512_1 = &h21

	#ifdef __FB_BIGENDIAN__
		dim as ushort vec_224_2 = &h5c7b 
		dim as ushort vec_256_2 = &h11af 
		dim as ushort vec_384_2 = &h6ec3 
		dim as ushort vec_512_2 = &h9083 

		dim as ulong vec_224_4 = &h6084347e 
		dim as ulong vec_256_4 = &h74ba2521 
		dim as ulong vec_384_4 = &h50e3853d 
		dim as ulong vec_512_4 = &h23be86d5 
	#else 
		'' we have to swap to network byte order so the byte values in memory match the expected values
		dim as ushort vec_224_2 = &h7b5c ' 0x5c7b
		dim as ushort vec_256_2 = &haf11 ' 0x11af
		dim as ushort vec_384_2 = &hce6e ' 0x6ec3
		dim as ushort vec_512_2 = &h8390 ' 0x9083

		dim as ulong vec_224_4 = &h7e348460 ' 0x6084347e
		dim as ulong vec_256_4 = &h2125ba74 ' 0x74ba2521 
		dim as ulong vec_384_4 = &h3d85e350 ' 0x50e3853d
		dim as ulong vec_512_4 = &hd586be23 ' 0x23be86d5
	#endif
	

	''Invalid
	ext_assert_STRING_EQUAL( "Invalid key length", ext.hashes.sha2( "doesn't matter", cast(ext.hashes.sha2_keylen,42) ) )

	''224
	ext_assert_STRING_EQUAL( "d14a028c2a3a2bc9476102bb288234c415a2b01f828ea62ac5b3e42f", ext.hashes.sha2(@vec_0, 0, ext.hashes.SHA224) )
	ext_assert_STRING_EQUAL( "3cd36921df5d6963e73739cf4d20211e2d8877c19cff087ade9d0e3a", ext.hashes.sha2(@vec_224_1, 1, ext.hashes.SHA224) )
	ext_assert_STRING_EQUAL( "daff9bce685eb831f97fc1225b03c275a6c112e2d6e76f5faf7a36e6", ext.hashes.sha2(@vec_224_2, 2, ext.hashes.SHA224) )
	ext_assert_STRING_EQUAL( "ae57c0a6d49739ba338adfa53bdae063e5c09122b77604780a8eeaa3", ext.hashes.sha2(@vec_224_4, 4, ext.hashes.SHA224) )

	ext_assert_STRING_EQUAL( "23097d223405d8228642a477bda255b32aadbce4bda0b3f7e36c9da7", ext.hashes.sha2( "abc", ext.hashes.SHA224 ) )

	''256
	ext_assert_STRING_EQUAL( "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", ext.hashes.sha2(@vec_0, 0, ext.hashes.SHA256) )
	ext_assert_STRING_EQUAL( "28969cdfa74a12c82f3bad960b0b000aca2ac329deea5c2328ebc6f2ba9802c1", ext.hashes.sha2(@vec_256_1, 1, ext.hashes.SHA256) )
	ext_assert_STRING_EQUAL( "5ca7133fa735326081558ac312c620eeca9970d1e70a4b95533d956f072d1f98", ext.hashes.sha2(@vec_256_2, 2, ext.hashes.SHA256) )
	ext_assert_STRING_EQUAL( "b16aa56be3880d18cd41e68384cf1ec8c17680c45a02b1575dc1518923ae8b0e", ext.hashes.sha2(@vec_256_4, 4, ext.hashes.SHA256) )

	ext_assert_STRING_EQUAL( "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855", ext.hashes.sha2( "" ) )
	ext_assert_STRING_EQUAL( "5e698150749eafa37b277f8ad390ff407aa3c011c92d6d2a09f2056de7590908", ext.hashes.sha2( FBEXT_TEST_STRING ) )
	ext_assert_STRING_EQUAL( "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad", ext.hashes.sha2( "abc" ) )
	ext_assert_STRING_EQUAL( "6a9c3911d69fdb86d4b5a6b93dbdd9d5d3b1125551416b7af129b29936ae48e2", ext.hashes.sha2( space(60) ) )
	
	ext_assert_STRING_EQUAL( "7ad04e5aa19eee72182c9a75ac71ba13833c53fc4dc8c815ceb7946d562e3631", ext.hashes.sha2("]SO6666666666666666666666666666666666666666666666666666666666666The quick brown fox jumps over the lazy dog") )

	''384
	ext_assert_STRING_EQUAL( "38b060a751ac96384cd9327eb1b1e36a21fdb71114be07434c0cc7bf63f6e1da274edebfe76f65fbd51ad2f14898b95b", ext.hashes.sha2(@vec_0, 0, ext.hashes.SHA384) )
	ext_assert_STRING_EQUAL( "b52b72da75d0666379e20f9b4a79c33a329a01f06a2fb7865c9062a28c1de860ba432edfd86b4cb1cb8a75b46076e3b1", ext.hashes.sha2(@vec_384_1, 1, ext.hashes.SHA384) )
	ext_assert_STRING_EQUAL( "53d4773da50d8be4145d8f3a7098ff3691a554a29ae6f652cc7121eb8bc96fd2210e06ae2fa2a36c4b3b3497341e70f0", ext.hashes.sha2(@vec_384_2, 2, ext.hashes.SHA384) )
	ext_assert_STRING_EQUAL( "936a3c3991716ba4c413bc03de20f5ce1c63703b3a5bdb6ab558c9ff70d537e46eb4a15d9f2c85e68d8678de5682695e", ext.hashes.sha2(@vec_384_4, 4, ext.hashes.SHA384) )

	ext_assert_STRING_EQUAL( "38b060a751ac96384cd9327eb1b1e36a21fdb71114be07434c0cc7bf63f6e1da274edebfe76f65fbd51ad2f14898b95b", ext.hashes.sha2( "", ext.hashes.SHA384 ) )
	ext_assert_STRING_EQUAL( "cb00753f45a35e8bb5a03d699ac65007272c32ab0eded1631a8b605a43ff5bed8086072ba1e7cc2358baeca134c825a7", ext.hashes.sha2( "abc", ext.hashes.SHA384 ) )
	
	''512
	ext_assert_STRING_EQUAL( "cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e", ext.hashes.sha2(@vec_0, 0, ext.hashes.SHA512) )
	ext_assert_STRING_EQUAL( "3831a6a6155e509dee59a7f451eb35324d8f8f2df6e3708894740f98fdee23889f4de5adb0c5010dfb555cda77c8ab5dc902094c52de3278f35a75ebc25f093a", ext.hashes.sha2(@vec_512_1, 1, ext.hashes.SHA512) )
	ext_assert_STRING_EQUAL( "55586ebba48768aeb323655ab6f4298fc9f670964fc2e5f2731e34dfa4b0c09e6e1e12e3d7286b3145c61c2047fb1a2a1297f36da64160b31fa4c8c2cddd2fb4", ext.hashes.sha2(@vec_512_2, 2, ext.hashes.SHA512) )
	ext_assert_STRING_EQUAL( "76d42c8eadea35a69990c63a762f330614a4699977f058adb988f406fb0be8f2ea3dce3a2bbd1d827b70b9b299ae6f9e5058ee97b50bd4922d6d37ddc761f8eb", ext.hashes.sha2(@vec_512_4, 4, ext.hashes.SHA512) )

	ext_assert_STRING_EQUAL( "ee180b331ce6100da9ee3be145f57281b9a0bad185be319c4b30a10ceaf0a8e17d7b0c74aa7c71db46d50b2c051dc9f02177f392f17442c0eb088801ee78fe6a", ext.hashes.sha2( FBEXT_TEST_STRING, ext.hashes.SHA512 ) )
	ext_assert_STRING_EQUAL( "cf83e1357eefb8bdf1542850d66d8007d620e4050b5715dc83f4a921d36ce9ce47d0d13c5d85f2b0ff8318d2877eec2f63b931bd47417a81a538327af927da3e", ext.hashes.sha2( "", ext.hashes.SHA512 ) )
	ext_assert_STRING_EQUAL( "ddaf35a193617abacc417349ae20413112e6fa4e89a97ea20a9eeee64b55d39a2192992a274fc1a836ba3c23a3feebbd454d4423643ce80e2a9ac94fa54ca49f", ext.hashes.sha2( "abc", ext.hashes.SHA512 ) )
	end sub

	sub test_sha3
		const SHA3_EMPTY_256 = "a7ffc6f8bf1ed76651c14756a061d662f580ff4de43b49fa82d80a4b80f8434a"
		const SHA3_ABC_256 = "3a985da74fe225b2045c172d6bd390bd855f086e3e9d525b46bfe24511431532"
		const SHA3_ABC_384 = "ec01498288516fc926459f58e2c6ad8df9b473cb0fc08c2596da7cf0e49be4b298d88cea927ac7f539f1edf228376d25"
		const SHA3_ABC_512 = "b751850b1a57168a5693cd924b6b096e08f621827444f70d884f5d0240d2712e10e116e9192af3c91a7ec57647e3934057340b4cf408d5a56592f8274eec53f0"
		const SHA3_A3x200_256 = "79f38adec5c20307a98ef76e8324afbfd46cfd81b22e3973c65fa1bd9de31787"
		const SHA3_A3x200_384 = "1881de2ca7e41ef95dc4732b8f5f002b189cc1e42b74168ed1732649ce1dbcdd76197a31fd55ee989f2d7050dd473e8f"
		const SHA3_A3x200_512 = "e76dfad22084a8b1467fcf2ffa58361bec7628edf5f3fdc0e4805dc48caeeca81b7c13c30adf52a3659584739a2df46be589c51ca1a4a8416df6545a1ce8ba00"

		const A3 = &ha3
		dim as ubyte ptr buf = new ubyte[200]
		memset(buf, A3, 200)

		ext_assert_STRING_EQUAL(SHA3_EMPTY_256, ext.hashes.sha3("", ext.hashes.SHA3_256))
		
		ext_assert_STRING_EQUAL(SHA3_ABC_256, ext.hashes.sha3("abc", ext.hashes.SHA3_256))
		ext_assert_STRING_EQUAL(SHA3_ABC_384, ext.hashes.sha3("abc", ext.hashes.SHA3_384))
		ext_assert_STRING_EQUAL(SHA3_ABC_512, ext.hashes.sha3("abc", ext.hashes.SHA3_512))

		ext_assert_STRING_EQUAL(SHA3_A3x200_256, ext.hashes.sha3(buf, 200, ext.hashes.SHA3_256))
		ext_assert_STRING_EQUAL(SHA3_A3x200_384, ext.hashes.sha3(buf, 200, ext.hashes.SHA3_384))
		ext_assert_STRING_EQUAL(SHA3_A3x200_512, ext.hashes.sha3(buf, 200, ext.hashes.SHA3_512))
		delete[] buf
	end sub

	private sub register constructor
		ext.tests.addSuite("ext-hashes")
		ext.tests.addTest("test_adler32", @test_adler32)
		ext.tests.addTest("test_crc32", @test_crc32)
		ext.tests.addTest("test_joaat", @test_joaat32)
		ext.tests.addTest("test_joaat64", @test_joaat64)
		ext.tests.addTest("test_md5", @test_md5)
		ext.tests.addTest("test_sha2", @test_sha2)
		ext.tests.addTest("test_sha3", @test_sha3)
	end sub

end namespace
