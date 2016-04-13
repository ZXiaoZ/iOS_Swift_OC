//
//  main.c
//  Socket_Client
//
//  Created by zxz on 4/13/16.
//  Copyright © 2016 zxz. All rights reserved.
//
#include <arpa/inet.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <unistd.h>

#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#define BUFF_SIZE 100

int main(int argc, const char * argv[]) {
    
    
    ///向服务器,特定的IP和端口发起请求
    struct sockaddr_in serv_addr;
    memset(&serv_addr, 0, sizeof(serv_addr));
    serv_addr.sin_family = AF_INET;
    serv_addr.sin_addr.s_addr = inet_addr("127.0.0.1");
    serv_addr.sin_port = htons(1234);
    
    
    
    ///不断的接受和发送消息给sever_socket
    char buffSend[BUFF_SIZE] = {0};
    char buffRev[BUFF_SIZE] = {};
//    while (1) {
        ///creat socket
        int client_socket = socket(AF_INET, SOCK_STREAM, 0);
        ///链接
        connect(client_socket, (struct sockaddr*)&serv_addr, sizeof(serv_addr));
        printf("输入要发送的消息: \n");
//        gets(buffSend);
        scanf("%s",buffSend);
        send(client_socket, buffSend, sizeof(buffSend), 0);
        
        recv(client_socket, buffRev, sizeof(buffRev), 0);
        
        printf("服务器返回:%s \n",buffRev);
        
        memset(buffSend, 0, sizeof(buffSend));
        memset(buffRev, 0, sizeof(buffRev));
        close(client_socket);
        
//    }
    
    
    
    
    /*
    //读取服务器传回的数据
    char buffer[40];
    read(client_socket, buffer, sizeof(buffer)-1);
    printf("Message from server:%s \n ",buffer);
    
    //close
    close(client_socket);
    */
    
    
    
    
    
    
    return 0;
}
