//
//  XZHashTable.h
//  HashTable
//
//  Created by zxz on 4/18/16.
//  Copyright © 2016 zxz. All rights reserved.
//

#ifndef XZHashTable_h
#define XZHashTable_h
#include "XZHash.h"

typedef struct _XZHashBucket {
    void                 *data;
    struct _XZHashBucket *next;
}XZHashBucket;
//hash表结构体
typedef struct {
    unsigned            count; //数量
    unsigned            nbBuckets; //可以存的数量
    XZHashBucket        *buckets; //数组
} XZHashTable;

XZHashTable *CreatHashTable(unsigned capacity);
bool InsertData(XZHashTable *table, void *data);
void XZHashLog (XZHashTable *table);


unsigned XZHash (void *data);
unsigned XZHashGet (void *data);
unsigned XZHashIndex (XZHashTable *table, void *data);


#endif /* XZHashTable_h */
