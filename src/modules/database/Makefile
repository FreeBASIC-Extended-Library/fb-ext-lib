ifeq ($(MT), 1)
	DLIB := ext-database.mt
	DOBJ := database.mt.o
	DS3O := sqlite3.mt.o
	DS3L := ext-database-driver-sqlite3.mt
	DSMYO := mysql.mt.o
	DSMYL := ext-database-driver-mysql.mt
else
	DLIB := ext-database
	DOBJ := database.o
	DS3O := sqlite3.o
	DS3L := ext-database-driver-sqlite3
	DSMYO := mysql.o
	DSMYL := ext-database-driver-mysql
endif

build-database : ../../../lib/$(TARGET)/$(DLIB).a ../../../lib/$(TARGET)/$(DS3L).a ../../../lib/$(TARGET)/$(DSMYL).a

../../../lib/$(TARGET)/$(DLIB).a : $(DOBJ)
	$(FBC) $(FBC_LFLAGS) -i ../../../inc $(DOBJ) -x ../../../lib/$(TARGET)/$(DLIB)

$(DOBJ) : database.bas ../../../inc/ext/database/database.bi ../../../inc/ext/database/driver.bi
	$(FBC) $(FBC_CFLAGS) $(IF $(MT),-mt) -i ../../../inc database.bas -o $(DOBJ)

drivers/$(DS3O) : drivers/sqlite3.bas ../../../inc/ext/database/driver.bi ../../../inc/ext/database/drivers/sqlite3driver.bi
	$(FBC) $(FBC_CFLAGS) $(IF $(MT),-mt) -i ../../../inc drivers/sqlite3.bas -o drivers/$(DS3O)

../../../lib/$(TARGET)/$(DS3L).a : drivers/$(DS3O)
	$(FBC) $(FBC_LFLAGS) $(IF $(MT),-mt) -i ../../../inc -x ../../../lib/$(TARGET)/$(DS3L) drivers/$(DS3O)

drivers/$(DSMYO) : drivers/mysql.bas ../../../inc/ext/database/driver.bi ../../../inc/ext/database/drivers/mysqldriver.bi
	$(FBC) $(FBC_CFLAGS) $(IF $(MT),-mt) -i ../../../inc drivers/mysql.bas -o drivers/$(DSMYO)

../../../lib/$(TARGET)/$(DSMYL).a : drivers/$(DSMYO)
	$(FBC) $(FBC_LFLAGS) $(IF $(MT),-mt) -i ../../../inc -x ../../../lib/$(TARGET)/$(DSMYL) drivers/$(DSMYO)

clean-database :
	$(RM) -f database*.o drivers/*.o
	$(RM) -f ../../../lib/$(TARGET)/libext-database*.a

