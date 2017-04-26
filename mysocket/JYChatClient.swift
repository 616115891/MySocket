//
//  JYChatClient.swift
//  iRich
//
//  Created by apple on 2017/2/2.
//  Copyright © 2017年 宋竟凯. All rights reserved.
//

import UIKit
import CFNetwork

typealias Task = (_ cancel : Bool) -> Void

func delay(_ time: TimeInterval, task: @escaping ()->()) ->  Task? {
    
    func dispatch_later(block: @escaping ()->()) {
        let t = DispatchTime.now() + time
        DispatchQueue.main.asyncAfter(deadline: t, execute: block)
    }
    var closure: (()->Void)? = task
    var result: Task?
    
    let delayedClosure: Task = {
        cancel in
        if let internalClosure = closure {
            if (cancel == false) {
                DispatchQueue.main.async(execute: internalClosure)
            }
        }
        closure = nil
        result = nil
    }
    
    result = delayedClosure
    
    dispatch_later {
        if let delayedClosure = result {
            delayedClosure(false)
        }
    }
    return result
}

class JYChatClient: NSObject,StreamDelegate {
    
    var charRoomId = 0
    
    internal static let shareClient:JYChatClient = {
        let data = JYChatClient()
        return data
    }()
    
    var inputStream:InputStream?
    var outputStream:OutputStream?
    
    var isConnect = true
    
    var buffer = [UInt8](repeating: 0, count: 128)
    
    //断线重连的时间
    let timeout:TimeInterval = 5
    
    ///第一次连接
    func openNetworkCommunication() {
        var readStream:  InputStream?
        var writeStream: OutputStream?
        self.isConnect = true
        Stream.getStreamsToHost(withName: "192.168.7.197", port: 906, inputStream: &readStream, outputStream: &writeStream)
        self.inputStream = readStream!
        self.outputStream = writeStream!
        
        
        self.inputStream?.delegate = self
        self.outputStream?.delegate = self
        
        self.inputStream?.schedule(in: RunLoop.main, forMode: RunLoopMode.defaultRunLoopMode)
        self.outputStream?.schedule(in: RunLoop.main, forMode: RunLoopMode.defaultRunLoopMode)
        
        self.inputStream?.open()
        self.outputStream?.open()
        
        var a = 1;
        var data = Data(bytes: &a, count: 1)
        let iData  = NSMutableDictionary()
        iData["UserID"] = 1819
        iData["Pwd"] = 11111
        let jsonData:Data!
        do{
            try jsonData = JSONSerialization.data(withJSONObject: iData, options: .prettyPrinted)
            data.append(jsonData)
            let iiData = String.init(data: data, encoding: String.Encoding.utf8)!
            let sendData = iiData.data(using: String.Encoding.utf8)!
            let uData = sendData.withUnsafeBytes({ (buffer:UnsafePointer<UInt8>?) -> UnsafePointer<UInt8> in
                
                return buffer!.advanced(by: 0)
            })
            outputStream?.write(uData, maxLength: sendData.count)
        }catch {
            print(error)
        }
        
    }
    
    ///发送消息
    func sendMessage(ToUserID:Int,ToUserName:String,PicID:Int,Cid:Int,message:String,messageFlag:String) {
        DispatchQueue.global().async {
            let iData  = NSMutableDictionary()
            iData["ChatRoom"] = 119
            iData["FromUserName"] = "Lamer"//胖虎 静香
            iData["ToUserID"] = ToUserID
            iData["ToUserName"] = ToUserName
            iData["PicID"] = PicID
            iData["Cid"] = Cid
            iData["Type"] = 2
            iData["Message"] = message
            iData["MessageFlag"] = messageFlag
            let jsonData:Data!
            do{
                try jsonData = JSONSerialization.data(withJSONObject: iData, options: .prettyPrinted)
                let iiData = String.init(data: jsonData, encoding: String.Encoding.utf8)!
                let sendData = iiData.data(using: String.Encoding.utf8)!
                let uData = sendData.withUnsafeBytes({ (buffer:UnsafePointer<UInt8>?) -> UnsafePointer<UInt8> in
                    
                    return buffer!.advanced(by: 0)
                })
                self.outputStream?.write(uData, maxLength: sendData.count)
            }catch {
                print(error)
            }
        }
    }
    
    func login() {
        DispatchQueue.global().async {
            var a = 2;
            var data = Data(bytes: &a, count: 1)
            let iData  = NSMutableDictionary()
            iData["UserID"] = 1819
            iData["UserName"] = "keyon"
            iData["Type"] = 1
            let jsonData:Data!
            do{
                try jsonData = JSONSerialization.data(withJSONObject: iData, options: .prettyPrinted)
                data.append(jsonData)
                let iiData = String.init(data: data, encoding: String.Encoding.utf8)!
                let sendData = iiData.data(using: String.Encoding.utf8)!
                let uData = sendData.withUnsafeBytes({ (buffer:UnsafePointer<UInt8>?) -> UnsafePointer<UInt8> in
                    
                    return buffer!.advanced(by: 0)
                })
                self.outputStream?.write(uData, maxLength: sendData.count)
            }catch {
                print(error)
            }
        }
        
    }
    
    func creatCid(userId:Int) {
        DispatchQueue.global().async {
            var a = 3;
            var data = Data(bytes: &a, count: 1)
            let iData  = NSMutableDictionary()
            iData["DestUser"] = 1824
            let jsonData:Data!
            do{
                try jsonData = JSONSerialization.data(withJSONObject: iData, options: .prettyPrinted)
                data.append(jsonData)
                let iiData = String.init(data: data, encoding: String.Encoding.utf8)!
                let sendData = iiData.data(using: String.Encoding.utf8)!
                let uData = sendData.withUnsafeBytes({ (buffer:UnsafePointer<UInt8>?) -> UnsafePointer<UInt8> in
                    
                    return buffer!.advanced(by: 0)
                })
                self.outputStream?.write(uData, maxLength: sendData.count)
            }catch {
                print(error)
            }
        }
        
    }
    //和对方建立链接
    func linkOther(userId:Int) {
        var a = 1;
        var data = Data(bytes: &a, count: 1)
        let iData  = NSMutableDictionary()
        iData["UserID"] = 1819
        iData["UserName"] = "keyon"
        iData["Type"] = 1
        let jsonData:Data!
        do{
            try jsonData = JSONSerialization.data(withJSONObject: iData, options: .prettyPrinted)
            data.append(jsonData)
            let iiData = String.init(data: data, encoding: String.Encoding.utf8)!
            let sendData = iiData.data(using: String.Encoding.utf8)!
            let uData = sendData.withUnsafeBytes({ (buffer:UnsafePointer<UInt8>?) -> UnsafePointer<UInt8> in
                
                return buffer!.advanced(by: 0)
            })
            outputStream?.write(uData, maxLength: sendData.count)
        }catch {
            print(error)
        }
    }
    

    func stream(_ stream: Stream, handle eventCode: Stream.Event) {
        
        if stream == inputStream {
            
            print("input")
            
            switch eventCode {
                
            case Stream.Event.openCompleted:
                print("input: openCompleted")
                break
            case Stream.Event.hasBytesAvailable:
                print("input: HasBytesAvailable")
                let len = inputStream?.read(&buffer, maxLength: buffer.count)
                if let len = len {
                    if len > 0 {
                        let data = Data.init(bytes: buffer, count: len)
                        //包头数据
                        let twiceData = NSData(bytes: buffer, length: buffer.count)
                        var i:Int!
                        twiceData.getBytes(&i, length: 1)
                        print(i)
                        //除去包头之后的json数据
                        let jsonRange = Range(data.startIndex + 1..<data.endIndex)
                        let jsonData = data.subdata(in: jsonRange)
                        let json = JSON(jsonData)
                        print(json)
                    }
                    
                }
                
            case Stream.Event.endEncountered:
                print("endEncountered")
                self.reConnect()
            case Stream.Event.errorOccurred:
                print("Can not connect to the host!")
                self.reConnect()
            default:
                print("default")
            }
        }
        else if stream === outputStream {
            
            print("output")
        }
        
    }
    ///MARK:-- 重新连接
    func reConnect() {
        let _ = delay(timeout) {
            DispatchQueue.global().async {
                if self.isConnect {
                    self.inputStream?.close()
                    self.inputStream?.remove(from: RunLoop.main, forMode: .defaultRunLoopMode)
                    self.outputStream?.close()
                    self.outputStream?.remove(from: RunLoop.main, forMode: .defaultRunLoopMode)
                    self.inputStream = nil
                    self.outputStream = nil
                    self.openNetworkCommunication()
                }
            }
        }
    }
    
    ///MARK:-- 断开连接
    func disConnect() {
        DispatchQueue.global().async {
            self.isConnect = false
            self.inputStream?.close()
            self.inputStream?.remove(from: RunLoop.main, forMode: .defaultRunLoopMode)
            self.outputStream?.close()
            self.outputStream?.remove(from: RunLoop.main, forMode: .defaultRunLoopMode)
            self.inputStream = nil
            self.outputStream = nil
        }
    }
}
