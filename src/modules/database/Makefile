ifeq ($(MT), 1)
	DLIB := libext-database.mt.a
	DOBJ := database.mt.o
	DS3O := sqlite3.mt.o
	DS3L := libext-database-driver-sqlite3.mt.a
	DSMYO := mysql.mt.o
	DSMYL := libext-database-driver-mysql.mt.a
else
	DLIB := libext-database.a
	DOBJ := database.o
	DS3O := sqlite3.o
	DS3L := libext-database-driver-sqlite3.a
	DSMYO := mysql.o
	DSMYL := libext-database-driver-mysql.a
endif

build-database : ../../../lib/$(TARGET)/$(DLIB).a ../../../lib/$(TARGET)/$(DS3L).a ../../../lib/$(TARGET)/$(DSMYL).a

../../../lib/$(TARGET)/$(DLIB).a : $(DOBJ)
	$(FBC) $(FBC_LFLAGS) -i ../../../include/freebasic $(DOBJ) -x ../../../lib/$(TARGET)/$(DLIB)

$(DOBJ) : database.bas ../../../include/freebasic/ext/database/database.bi ../../../include/freebasic/ext/database/driver.bi
	$(FBC) $(FBC_CFLAGS) $(IF $(MT),-mt) -i ../../../include/freebasic database.bas -o $(DOBJ)

drivers/$(DS3O) : drivers/sqlite3.bas ../../../include/freebasic/ext/database/driver.bi ../../../include/freebasic/ext/database/drivers/sqlite3driver.bi
	$(FBC) $(FBC_CFLAGS) $(IF $(MT),-mt) -i ../../../include/freebasic drivers/sqlite3.bas -o drivers/$(DS3O)

../../../lib/$(TARGET)/$(DS3L).a : drivers/$(DS3O)
	$(FBC) $(FBC_LFLAGS) $(IF $(MT),-mt) -i ../../../include/freebasic -x ../../../lib/$(TARGET)/$(DS3L) drivers/$(DS3O)

drivers/$(DSMYO) : drivers/mysql.bas ../../../include/freebasic/ext/database/driver.bi ../../../include/freebasic/ext/database/drivers/mysqldriver.bi
	$(FBC) $(FBC_CFLAGS) $(IF $(MT),-mt) -i ../../../include/freebasic drivers/mysql.bas -o drivers/$(DSMYO)

../../../lib/$(TARGET)/$(DSMYL).a : drivers/$(DSMYO)
	$(FBC) $(FBC_LFLAGS) $(IF $(MT),-mt) -i ../../../include/freebasic -x ../../../lib/$(TARGET)/$(DSMYL) drivers/$(DSMYO)

clean-database :
	$(RM) -f database*.o drivers/*.o
	$(RM) -f ../../../lib/$(TARGET)/libext-database*.a

