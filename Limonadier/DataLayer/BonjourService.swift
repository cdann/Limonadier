//
//  BonjourService.swift
//  DataLayer
//
//  Created by celine dann on 02/02/2020.
//  Copyright © 2020 celine dann. All rights reserved.
//

import Foundation

protocol BonjourServiceDelegate {
    func error(msg: String?)
}

class BonjourService: NSObject, NetServiceBrowserDelegate, NetServiceDelegate {
    var serviceBrowser: NetServiceBrowser
    var serviceResolver: NetService?
    var services: [NetService] = []
    var delegate: BonjourServiceDelegate?
    
    override init() {
        serviceBrowser = NetServiceBrowser()
        super.init()
        serviceBrowser.delegate = self
        self.serviceBrowser.searchForServices(ofType: "_escarpolette._tcp", inDomain: "local")
    }
    
    // MARK: NetServiceBrowserDelegate
    func netServiceBrowser(_ browser: NetServiceBrowser, didFind service: NetService, moreComing: Bool) {
        self.serviceResolver = service
        self.serviceResolver?.resolve(withTimeout: 300)
        self.serviceResolver?.delegate = self
    }
    
    // MARK: NetServiceDelegate
    func netServiceDidResolveAddress(_ sender: NetService) {
        /*
         [self.serviceResolver stop];
            NSLog(@"%ld", (long)service.port);
         
            for (NSData* data in [service addresses]) {
                char addressBuffer[100];
                struct sockaddr_in* socketAddress = (struct sockaddr_in*) [data bytes];
                int sockFamily = socketAddress->sin_family;
                if (sockFamily == AF_INET) {
                    const char* addressStr = inet_ntop(sockFamily,
                                                       &(socketAddress->sin_addr), addressBuffer,
                                                       sizeof(addressBuffer));
         
                    int port = ntohs(socketAddress->sin_port);
                    if (addressStr && port) {
                        NSLog(@"Found service at %s:%d", addressStr, port);
                        NSString *urlString = [NSString stringWithFormat:@"http://%s:%d", addressStr, port];
                        NSURL *url = [ [ NSURL alloc ] initWithString: urlString];
                        [[UIApplication sharedApplication] openURL:url];
                    }
                }
            }
         */
        
        self.serviceResolver?.stop()
        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
        sender.addresses?.forEach({[weak self] (addressData) in
            addressData.withUnsafeBytes { ptr in
                guard let sockaddr_ptr = ptr.baseAddress?.assumingMemoryBound(to: sockaddr.self) else {
                    // handle error
                    self?.delegate?.error(msg: nil)
                    return
                }
                let sockaddr = sockaddr_ptr.pointee
                guard getnameinfo(sockaddr_ptr, socklen_t(sockaddr.sa_len), &hostname, socklen_t(hostname.count), nil, 0, NI_NUMERICHOST) == 0 else {
                    self?.delegate?.error(msg: nil)
                    return
                }
            }
            let ipAddress = String(cString:hostname)
            print(ipAddress)
        })
        
    }
    
    func netService(_ sender: NetService, didNotResolve errorDict: [String : NSNumber]) {
        self.delegate?.error(msg: "no escarpolette found")
        self.serviceResolver?.stop()
    }
}

