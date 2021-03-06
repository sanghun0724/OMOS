
[![Platform](https://img.shields.io/cocoapods/p/LFAlertController.svg?style=flat)](http://cocoapods.org/pods/LFAlertController)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)
 ### >>> [APP STORE LINK](https://apps.apple.com/kr/app/omos/id1615388062?l=ko, "APPSTORE link") <<<

[- ๐ด omos์ ๋ํ ์๊ฐ](#omos-์๊ฐ)  
[- ๐ก ์ฃผ์ ๊ธฐ๋ฅ๋ค](#์ฃผ์-๊ธฐ๋ฅ)  
[- ๐ omos Project Architecture](#omos-project-architecture)  
ใใใ[- MVVM **Clean Architecture**](#mvvm-clean-architecture-๊ธฐ๋ฐ)  
ใใใ[- URLRequestConvertible ๊ธฐ๋ฐ **Network Layer**](#urlrequestconvertible-๊ธฐ๋ฐ-**network-layer**)   
[- ๐จ ๋ผ์ด๋ธ๋ฌ๋ฆฌ](#๋ผ์ด๋ธ๋ฌ๋ฆฌ)    
[- ๐ ํ๋ก์ ํธ ๊ธฐ์  TALK](#ํ๋ก์ ํธ-๊ธฐ์ -talk)    
ใใใ[- UI based only Code](#ui-based-only-code)   
ใใใ[- URLConvertible์ ํ์ฉํ์ฌ ์์ฝ๊ฒ RefreshToken ๊ฐฑ์ ](#urlconvertible์-ํ์ฉํ์ฌ-์์ฝ๊ฒ-refreshtoken-๊ฐฑ์ )    
ใใใ[- ๋ถ๋ฆฌ๋ UseCase๋ค (ISP์์น)](#๋ถ๋ฆฌ๋-useCase๋ค-(isp์์น))    
ใใใ[- Single ๋ก ๊ฐํธํ NetworkCall](#single-๋ก-๊ฐํธํ-networkCall)     
ใใใ[- CI Travis CI >> Github Action](#ci-travis-ci--github-action)    
   
# omos ์๊ฐ

๐ง **์์์ ํตํด ์์ ๋ง์ ๊ธฐ๋ก์ ๋ด๊ณ , ํจ๊ป ๊ฐ์ฑ์ ๊ณต์ ํ๋ ์๋น์ค**
- ์์์ ๋งค๊ฐ๋ก ๊ธฐ๋กํ๊ณ  ์ฐฝ์ํ๋ ๊ฐ์ฑ ๊ธฐ๋ก SNS ์๋น์ค
- ์ฌ์ฉ์์ ํ๋ฃจ ์ผ๊ณผ์ ๋ฐ๋ฅธ ๊ธฐ๋ก์ด๋, ๋จ์ด ํน์ ๋ฌธ์ฅ์ผ๋ก ๊ธ๊ฐ์ ์ฃผ๋ ๊ธฐ์กด์ ๋ค์ด์ด๋ฆฌ ํ์์ด ์๋, โ์์โ์ด๋ผ๋ ๋ณด๋ค ๋ ๊ฐ๊ฐ์ ์ธ ์์ฌ๋ฅผ ํตํด ๋ค์ฑ๋ก์ด ์ฐฝ์ ๋ฐ ๊ธฐ๋ก
- ๋์ ๋ ์์ ๋ง์ ์์ ๊ธฐ๋ก์ ํตํด ๋น์ ์์ ์ ์๊ฐ, ๊ฐ์  ๋ฑ์ ์์ํ ์ถ์ต
- ๊ณต๊ฐ ๊ธฐ๋ฅ์ ๋ฐํ์ผ๋ก ๋ค๋ฅธ ์ฌ์ฉ์๋ค๊ณผ ๊ฐ์ฑ์ ๋๋๊ณ , ์๋ก ๊ณต๊ฐ
### >>>>> [omos ์๊ฐ ํ์ด์ง๋ก ์ด๋](https://melodious-passbook-4b9.notion.site/omos-488a3f87b45e49f5bdc458d77c25cb39) <<<<<

# ์ฃผ์ ๊ธฐ๋ฅ ( ๊ฐ๋ฐ๊ธฐ๊ฐ: 2022 . 02 . 07 ~ 2022 .04 . 09 )

| ๋ก๊ทธ์ธ | ํ์๊ฐ์ 1 | ํ์๊ฐ์ 2 | ๋น๋ฐ๋ฒํธ ์ฐพ๊ธฐ | 
|:--------:|:--------:|:--------:|:--------:|
| <img src=https://user-images.githubusercontent.com/66512239/165897165-b7a7b1e4-38e7-4609-95a5-b4e78759a66b.png width=200> | <img src=https://user-images.githubusercontent.com/66512239/165897176-feaf224c-ddb4-4d65-8f0d-0b39d7dc5a0e.png width=200> | <img src=https://user-images.githubusercontent.com/66512239/165897187-e144c793-588e-49e6-a82b-28ea1156b669.png width=200> | <img src=https://user-images.githubusercontent.com/66512239/165897183-fa400241-a00a-4444-a82b-4e9f17609381.png width=200> |

| ํํ๋ฉด | ๋ง์ด ๋ ์ฝ๋ | ์ ์ฒด ๋ ์ฝ๋ | my DJ | 
|:--------:|:--------:|:--------:|:--------:|
| <img src=https://user-images.githubusercontent.com/66512239/165903162-f4b3d619-3bcd-4c6b-a021-6269dd662759.gif width=200>|<img src=https://user-images.githubusercontent.com/66512239/165896288-468ca20d-1040-4b77-b262-f86d431a4bf3.gif width=200>|<img src=https://user-images.githubusercontent.com/66512239/165903893-680baa09-ba08-4f63-af5f-5ff0700fcafd.gif width=200>|<img src=https://user-images.githubusercontent.com/66512239/165904848-ddc46825-d45d-4f9b-ac51-4f8cf6e551c1.gif width=200>|

| ๊ธ ์์ฑ ๋ธ๋๊ฒ์ | ๊ฒ์๊ฒฐ๊ณผ ๋ทฐ 1 | ๊ฒ์๊ฒฐ๊ณผ ๋ทฐ 2 | ์นดํ์ฝ๋ฆฌ ๋ทฐ | 
|:--------:|:--------:|:--------:|:--------:|
|<img src=https://user-images.githubusercontent.com/66512239/165905222-e0646254-15f1-4331-9649-b72cacf1cd5e.gif width=200>|<img src=https://user-images.githubusercontent.com/66512239/165905579-2fe933a7-325c-45b2-b6c0-27ae309221de.gif width=200>|<img src=https://user-images.githubusercontent.com/66512239/165906147-923a3b22-31f9-47ac-add8-0d7ad7503e52.gif width=200>|<img src=https://user-images.githubusercontent.com/66512239/165906813-2a37fa6a-9be8-482a-8670-af7a96866e46.gif width=200>|

| ํ์ค ์์ฑ | ์ฌ๋ฌ์ค ์์ฑ | ๊ฐ์ฌ ํด์ ์์ฑ | ์์๋ณ ๋ ์ฝ๋ ๋ฆฌ์คํธ |
|:--------:|:--------:|:--------:|:--------:|
|<img src=https://user-images.githubusercontent.com/66512239/165909178-ec60836d-79cb-4c2a-bda6-d33aaacd9502.gif width=200>|<img src=https://user-images.githubusercontent.com/66512239/165909667-da7788d1-693d-4a4f-958a-81a571773780.gif width=200>|<img src=https://user-images.githubusercontent.com/66512239/165910048-f39d338b-441d-4baa-9435-2efa95e596d1.gif width=200>|<img src=https://user-images.githubusercontent.com/66512239/165910806-3b176e5b-1545-40a3-aa43-4e6b932005f0.gif width=200>|

| ์นด๋ฐ์ฝ๋ฆฌ๋ณ ๋ฆฌ์คํธ | ๋ฆฌ์คํธ ํํฐ | my DJ ํ๋กํ | ์ ์  ์ ๊ณ  ์ฐจ๋จ |
|:--------:|:--------:|:--------:|:--------:|
|<img src=https://user-images.githubusercontent.com/66512239/165912018-3d2f3c06-51e8-4dbf-ad18-95af7d6d818f.gif width=200>|<img src=https://user-images.githubusercontent.com/66512239/165912165-a79ef25d-ab79-4f42-8b55-37443e31987c.gif width=200>|<img src=https://user-images.githubusercontent.com/66512239/165912335-12dd3cd0-7f4d-4605-9452-07c06cc226ae.gif width=200>|<img src=https://user-images.githubusercontent.com/66512239/165912385-ef09bcea-cd5d-4e7e-b4c7-b9f49dc4570d.png width=200>|

| ๋ง์ดํ๋กํ | ์ข์์&์คํฌ๋ฉ ๋ฆฌ์คํธ | ํ๋กํ๋ณ๊ฒฝ | ๋น๋ฐ๋ฒํธ ๋ณ๊ฒฝ |
|:--------:|:--------:|:--------:|:--------:|
|<img src=https://user-images.githubusercontent.com/66512239/165915061-8c5f0fe8-0465-4461-8d5a-323bddac076f.gif width=200>|<img src=https://user-images.githubusercontent.com/66512239/165915214-2f8c9ea3-3789-473b-b138-807d952a8a04.gif width=200>|<img src=https://user-images.githubusercontent.com/66512239/165915252-2b306dc8-23c3-4218-8bbc-2f7e2861e443.png width=200>|<img src=https://user-images.githubusercontent.com/66512239/165915263-caaa4c71-6182-4e26-a9ab-61d9ebc38dd3.png width=200>|

| ๋ ์ฝ๋ ์ ๊ณ  | ๋ ์ฝ๋ ๋ํ์ผ ๋ทฐ A |  ๋ ์ฝ๋ ๋ํ์ผ ๋ทฐ B |  ๋ ์ฝ๋ ๋ํ์ผ ๋ทฐ C | ์ธ์คํ๊ทธ๋จ ๊ณต์  |
|:--------:|:--------:|:--------:|:--------:|:--------:|
|<img src=https://user-images.githubusercontent.com/66512239/165915770-9933ae62-4d78-4dff-b1a1-5001ffb2413b.png width=200>|<img src=https://user-images.githubusercontent.com/66512239/165915781-11a846c6-c3ec-4f27-88a0-0c50bd811835.png width=200>|<img src=https://user-images.githubusercontent.com/66512239/165921607-633ee32d-8600-4338-ac8e-43242f28be04.png width=200>|<img src=https://user-images.githubusercontent.com/66512239/165921617-a725fd90-1136-4ac3-a4ce-0ee518c27dfc.png width=200>|<img src=https://user-images.githubusercontent.com/66512239/165915787-626727b7-13e9-45da-af49-acdd89e99205.png width=200>|


# omos Project Architecture
## MVVM Clean Architecture ๊ธฐ๋ฐ 
- ์ข ๋ ๊ฐ๋์ฑ ์ข์, ์ข ๋ ํด๋ฆฐํ, ์ข ๋ ๊ฐ๋ฒผ์ด ์ฝ๋๋ฅผ ์ํด MVVM ๊ตฌ์กฐ๋ฅผ ์ฌ์ฉํ๊ฒ ๋์์ต๋๋ค. 
- ๊ธฐ์กด VC์ ์ฑ์์ ๋ถ์ฐ์์ผ MVC์ ๋จ์ ์ ๋ณด์ํ๊ณ  ์ฝ๋๋ฅผ ๊ฐ์ฒด์งํฅ์ ์ผ๋ก ์ง๊ณ ์ ๊ณ ๋ฏผํ์์ต๋๋ค. 
<img src=https://user-images.githubusercontent.com/66512239/165925082-1ee71828-5480-4c85-a482-fa18b6efb4a2.png width=500>

## URLRequestConvertible ๊ธฐ๋ฐ **Network Layer**
    
 ```swift
 protocol TargetType: URLRequestConvertible {
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: RequestParams? { get }
}

extension TargetType {
    // URLRequestConvertible ๊ตฌํ
    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
        var urlRequest = try URLRequest(url: url.appendingPathComponent(path), method: method)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        switch parameters {
        case .query(let request):
            let params = request?.toDictionary() ?? [:]
            let queryParams = params.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            var components = URLComponents(string: url.appendingPathComponent(path).absoluteString)
            components?.queryItems = queryParams
            urlRequest.url = components?.url
        case .body(let request):
            let params = request?.toDictionary() ?? [:]
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
        default:
            print("param is nil")
        }
        return urlRequest
    }
}

enum RequestParams {
    case query(_ parameter: Encodable?)
    case body(_ parameter: Encodable?)
}

extension Encodable {
    func toDictionary() -> [String: Any] {
        guard let data = try? JSONEncoder().encode(self),
              let jsonData = try? JSONSerialization.jsonObject(with: data),
              let dictionaryData = jsonData as? [String: Any] else { return [:] }
        return dictionaryData
    }
}
   
 ```

# ๋ผ์ด๋ธ๋ฌ๋ฆฌ

#### Firebase/analatics/Crashtics

- ํ์ด์ด๋ฒ ์ด์ค๋ ๊ฐํธํ ์ฌ์ฉ์ ๊ด๋ฆฌ์ ํฌ๋ฌ์ฌ ๊ด๋ฆฌ๋ฅผ ์ํด ๋์ํ์์ต๋๋ค.

#### RxSwift/RxGesture/RxViewController

- ์ฑ์ ์ ์ฒด์ ์ธ ๋น๋๊ธฐ ๊ด๋ฆฌ ๋ผ์ด๋ธ๋ฌ๋ฆฌ๋ก RxSwift๋ฅผ ์ฌ์ฉํ์์ต๋๋ค. 
- NotificationCenter๋ ์ฝ๋๋ค์ด ํฉ์ด์ ธ ์์ด ๊ด๋ฆฌ๊ฐ ์ด๋ ต๊ณ , ๋จ์ํ ํด๋ก์ ธ๋ ํ๋ก๋ฏธ์คํท ๊ฐ์ ์ฝ๋ฐฑ์ ์ฝ๋ฐฑ ์ง์ฅ + ๊ฐ๊ฒฐํ์ง ์์ ์ ๋ฌธ์ ๋ก RxSwift ๋ฅผ ์ ํํ๊ฒ ๋์์ต๋๋ค. 

#### SnapKit

- ์ฝ๋๋ก๋ง ๋ทฐ๋ฅผ ์์ฑํ๊ธฐ ๋๋ฌธ์ ์คํ ๋ ์ด์์ ์ค์ ์ ์ข ๋ ๊ฐํธํ๊ฒ ํ๊ธฐ์ํด ๋์ํ์ต๋๋ค.

#### SwiftLint

- ๋ฆฌํฉํ ๋ง ์์์์ ์ฝ๋ ์ปจ๋ฒค์์ ์ก์๋ ์ฌ์ฉํ์์ต๋๋ค. 
- ์ฝ๋ ์์ฑ์์ ์๋ชป๋ ์ต๊ด๋ค์ ์ก์ ์ ์์๊ณ  ์ดํ ์ฝ๋ ์ปจ๋ฒค์์ ๋ํ ๊ด์ฌ์ด ๋ ์ปค์ก์ต๋๋ค.

#### AWSS3

- imageํ์ผ์ ์๋ก๋๋ฅผ ์ํด ์ฌ์ฉํ์์ต๋๋ค.

#### 

# ํ๋ก์ ํธ ๊ธฐ์  TALK

### UI based Only Code

### URLConvertible์ ํ์ฉํ์ฌ ์์ฝ๊ฒ RefreshToken ๊ฐฑ์  

### ๋ถ๋ฆฌ๋ UseCase๋ค (ISP์์น)

### Single ๋ก ๊ฐํธํ NetworkCall

### CI Travis CI >> Github Action







