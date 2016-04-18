//
//  main.c
//  HashTable
//
//  Created by zxz on 4/18/16.
//  Copyright © 2016 zxz. All rights reserved.
//

#include <stdio.h>
#include "XZHashTable.h"
#include <string.h>


typedef struct _Node {
    void *data;
    struct _Node *next;
}Node;

void logNode(Node *node){
    while (node != NULL){
        printf("(%s)\n",(char *)node->data);
        node = node->next;
    }
}

bool insertNode(Node *node,void *data){
    if (node == NULL) {
        return false;
    }
    if (node->data == NULL) {
        node->data = data;
        return true;
    }
    while (node->next != NULL) {
        node = node->next;
    }
    node->next = malloc(sizeof(Node));
    node->next->data = data;
    return true;
}

void *getString(char *string){
    char *str = string;
    str = "123";
    return str;
}
void testNode(){
    Node *node = malloc(sizeof(Node));
//    insertNode(node, s0);
//    insertNode(node, s1);
//    insertNode(node, s2);
    
    testNode(node);
    
    
//    Node *nodes = malloc(sizeof(Node)*5);
//    insertNode(nodes, s0);
//    insertNode(nodes+sizeof(Node)*1, s1);
//    insertNode(nodes+sizeof(Node)*2, s2);
//    logNode(nodes+sizeof(Node)*1);
}

int main(int argc, const char * argv[]) {
    char *s0 = "0abcd";
    char *s1 = "1abcd";
    char *s2 = "2abcd";
    char *s3 = "3abcd";
    char *s4 = "4abcd";
    char *s5 = "5abcd";
    char *s6 = "6abcd";
    char *s7 = "7abcd";
    char **a1;
    
    XZHashTable *table = CreatHashTable(5);
    InsertData(table, s0);
    InsertData(table, s1);
    InsertData(table, s2);
    InsertData(table, s3);
    XZHashLog(table);
    
    
    return 0;
}
