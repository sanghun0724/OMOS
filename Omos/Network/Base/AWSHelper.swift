//
//  AWSHelper.swift
//  Omos
//
//  Created by sangheon on 2022/03/27.
//

import NIO
import SotoS3
import UIKit

struct AWSConstants {
    let bucket = "omos-image"
    let region: Region = .apnortheast2
    let awsClient = AWSClient(
        credentialProvider: .static(accessKeyId: "AKIAVIJ5RLU3AVRPOYOA", secretAccessKey: "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"),
        httpClientProvider: .createNew
    )
}

enum AwsType {
    case profile
    case record
}

class AWSS3Helper {
    let bucket = AWSConstants().bucket
    let s3 = S3(client: AWSConstants().awsClient, region: AWSConstants().region)

    func uploadImage(_ image: UIImage, sender: UIViewController, imageName: String, type: AwsType, completion: @escaping (String?) -> Void) {
        // check internet connection
        var imageData: Data = .init(count: 0)

        if type == .profile {
            guard let data = image.jpegData(compressionQuality: 0.1) else {
                completion(nil)
                return
            }
            imageData = data
        } else if type == .record {
            guard let data = image.jpegData(compressionQuality: 0.26) else {
                completion(nil)
                return
            }
            imageData = data
        }

      //  let uuid = UUID().uuidString
        let fileName = "\(imageName).png"

        // Put an Object
        let putObjectRequest = S3.PutObjectRequest(acl: .publicRead,
                                                   body: .data(imageData),
                                                   bucket: bucket,
                                                   contentLength: Int64(imageData.count),
                                                   key: fileName)

        let futureOutput = s3.putObject(putObjectRequest)

        futureOutput.whenSuccess({ response in
            print(response)
            completion(fileName)
        })

        futureOutput.whenFailure({ error in
            print(error.localizedDescription)
            completion(nil)
        })
    }
}

struct AwsDeleteImageRequest: Codable {
    let directory: String
    let fileName: String
}
