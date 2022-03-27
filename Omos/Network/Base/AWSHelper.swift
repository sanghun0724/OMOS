//
//  AWSHelper.swift
//  Omos
//
//  Created by sangheon on 2022/03/27.
//

import UIKit
import SotoS3
import NIO


struct AWSConstants {
    let bucket = "omos-image"
    let region:Region = .apnortheast2
    let awsClient = AWSClient(
        credentialProvider: .static(accessKeyId: "", secretAccessKey: ""),
        httpClientProvider: .createNew
    )
}

class AWSS3Helper {
    
   
    
    let bucket = AWSConstants().bucket
    let s3 = S3(client: AWSConstants().awsClient, region: AWSConstants().region)
        
    func uploadImage(_ image: UIImage, sender: UIViewController, completion: @escaping (String?) -> ()) {
        
        // check internet connection
        
        guard let imageData = image.jpegData(compressionQuality: 1) else {
            completion(nil)
            return
        }
        
        let uuid = UUID().uuidString
        let fileName = "\(uuid).jpeg"
        
        // Put an Object
        let putObjectRequest = S3.PutObjectRequest(acl: .publicRead,
                                                   body: .data(imageData),
                                                   bucket: bucket,
                                                   contentLength: Int64(imageData.count),
                                                   key: fileName)
        
        let futureOutput = s3.putObject(putObjectRequest)
        
        futureOutput.whenSuccess({ (response) in
            print(response)
            completion(fileName)
        })
        
        futureOutput.whenFailure({ (error) in
            print(error)
            completion(nil)
        })
        
    }
    
}



