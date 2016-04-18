//
//  XZHashTable.c
//  HashTable
//
//  Created by zxz on 4/18/16.
//  Copyright © 2016 zxz. All rights reserved.
//

#include "XZHashTable.h"
#define BUCKETSIZE sizeof(XZHashBucket)


static unsigned log2 (unsigned x) { return (x<2) ? 0 : log2 (x>>1)+1; };
static unsigned exp2m1 (unsigned x) { return (1 << x) - 1; };

unsigned XZHash(void *data) {
    return (((unsigned) data) >> 16) ^ ((unsigned) data);//保留高16位,移除其余位
}

unsigned XZHashIndex (XZHashTable *table, void *data) {
    return (XZHash(data) % table->nbBuckets)*(sizeof(XZHashBucket)); // 0 - (nbBuckets-1)
}

XZHashTable *CreatHashTable(unsigned capacity) {
    XZHashTable *table = malloc(sizeof(XZHashTable));
//    memset(table, 0, sizeof(XZHashTable));

    table->count = 0;
    table->nbBuckets = exp2m1(log2(capacity)+1);
    printf("nbBuckets:%i \n",table->nbBuckets);
    table->buckets = (XZHashBucket *)malloc(sizeof(XZHashBucket ) * table->nbBuckets); //初始化bucket指针数组所需的内存
//    memset(table->buckets, table->nbBuckets, sizeof(XZHashBucket *) * table->nbBuckets);
    return table;
}

XZHashBucket *GetData (XZHashTable *table, void *data) {
    XZHashBucket *bucket;
    if (!table) return NULL; //判断table指针是否存在
    unsigned index = XZHashIndex(table, data);
    if (table->buckets+index == NULL) {
        return NULL;
    }
    //index的bucket指针存在
    bucket = (XZHashBucket *)(table->buckets+index);
    while (bucket) {
        if (bucket->data == data){
            return bucket;
        }
        bucket = bucket->next;
    }
    return NULL;
}

bool InsertData(XZHashTable *table, void *data){
    
    if (!table) return false;
    if (GetData(table, data) != NULL){
        printf("数据已经在表中了 \n");
        return false;
    }
    unsigned index = XZHashIndex(table, data);
    XZHashBucket *bucket = (XZHashBucket *)(table->buckets+index);
    
    if (bucket->data == NULL){ //data指向空
        bucket->data = data;
        table->count++;
        return true;
    }
    //如果data存在
    while (bucket->next != NULL) { //获得bucket->next == NULL的指针
        bucket = bucket->next;
    }
    bucket->next = (XZHashBucket *)malloc(sizeof(XZHashBucket));//保证最后一个数据的next指针所指向内存初始化
    bucket->next->data = data;
    table->count++;
    return false;
}

void XZBucketListLog(XZHashBucket *bucket, unsigned index){
    while (bucket) {
        if (bucket->data){
            printf("(%i,%s)\n",index,(char *)bucket->data);
        }
        bucket = bucket->next;
    }
    printf("-----------\n");
}

void XZHashLog (XZHashTable *table){
    printf("(count:%i,total:%i)\n",table->count,table->nbBuckets);
    
    XZHashBucket *bucket;
    unsigned index = 0;
    while (index < table->nbBuckets) {
        
        if (table->buckets+(index*BUCKETSIZE) != NULL) {
            bucket = (XZHashBucket *)table->buckets+(index*BUCKETSIZE);
            XZBucketListLog(bucket, index);
        }
        index ++;
        bucket = table->buckets+(index*BUCKETSIZE);
    }
}


