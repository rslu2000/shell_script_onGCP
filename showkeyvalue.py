import leveldb
db=leveldb.LevelDB('./')

for key, value in db.RangeIter():
    print 'key:',key
    print 'value:',value