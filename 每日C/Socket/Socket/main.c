//
//  main.c
//  Socket
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
    ///创建socket,socket类似文件,也有读写等操作.AF(Address Family),INET(internet),常用的有AF_INET(ipv4)和AF_INET6
    ///SOCK_STREAM:stream socket,SOCK_DGRAM:datagram socket 数据传输形式
    ///IPPROTO_TCP:TCP协议
    int serv_socket = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
    printf("serv_socket:%d \n",serv_socket);
    
    ///将socket和IP,端口绑定
    struct sockaddr_in serv_addr;
    
    //将地址的值都初始化为0,确保后边sockaddr和sockaddr_in的类型转换
    memset(&serv_addr, 0, sizeof(serv_addr));
    serv_addr.sin_family  = AF_INET; //ipv4 地址族
    serv_addr.sin_addr.s_addr = inet_addr("127.0.0.1"); //32位地址,为一个特殊的地址,代表本机地址
    serv_addr.sin_port = htons(1234); //端口号2个字节的int:系统端口"1-1024"
    //绑定socket和socket地址,sockaddr和sockaddr_in长度相同,后者为通用地址类型
    bind(serv_socket, (struct sockaddr*)&serv_addr, sizeof(serv_addr));
    
    ///listen,第二个参数为请求队列的长度,当socket正在处理客户端请求时,如果有新的请求,则放进缓冲队列
    listen(serv_socket, 20);
    
    ///接受客户端请求
    struct sockaddr_in client_addr; //客户端地址
    socklen_t client_addr_size = sizeof(client_addr); //客户端地址长度
    char buffer[BUFF_SIZE] = {0};
    
    ///向客户端发送数据
//    while (1) {
        int client_socket = accept(serv_socket, (struct sockaddr*)&client_addr, &client_addr_size); //返回客户端socket
        printf("client_socket:%d \n",client_socket);
        printf("client_socket.addr_family:%hhu \n",client_addr.sin_family);
        
        printf("client_socket.addr:%d \n",client_addr.sin_addr.s_addr);
    
        long int dataLength = recv(client_socket, buffer, sizeof(buffer), 0);//接受客户端数据
        send(client_socket, buffer, dataLength, 0);//发送数据,此处直接返回了数据
        
        close(client_socket);
        memset(buffer, 0, sizeof(buffer));//重置缓存
//    }

//    char str[] = "Hello Socket!";
//    write(client_socket, str, sizeof(str));
    
    ///其他函数
    //1.TCP默认为阻塞模式,也可以为非阻塞模式,注意区别
    //输入输出缓冲区的大小一般为8k
    //2.数据的粘包,即数据没及时被发送或接受,堆积在缓存区.
    unsigned int optVal;
    int optLen = sizeof(optVal);
    getsockopt(serv_socket, SOL_SOCKET, SO_SNDBUF, &optVal, (socklen_t*)&optLen);
    printf("Buffer length: %d \n",optVal);
    
    
    return 0;
}
